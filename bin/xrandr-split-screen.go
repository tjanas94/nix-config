package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	factorLeft, err := strconv.Atoi(os.Args[1])
	if err != nil {
		log.Fatal(err)
	}

	factorRight, err := strconv.Atoi(os.Args[2])
	if err != nil {
		log.Fatal(err)
	}

	monitorsList, err := exec.Command("xrandr", "--listmonitors").Output()
	if err != nil {
		log.Fatal(err)
	}

	lines := strings.Split(string(monitorsList), "\n")
	primaryMonitor := findByStr(lines, "*")
	fields := strings.Fields(primaryMonitor)
	geometryStr := findByStr(fields, "/")
	geometry, err := parseGeometry(geometryStr)
	if err != nil {
		log.Fatal(err)
	}

	output := fields[len(fields)-1]

	commands := []string{
		fmt.Sprintf(
			"xrandr --setmonitor virtual-left %d/%dx%d/%d+%d+%d %s",
			geometry.WidthPX*factorLeft/factorRight,
			geometry.WidthMM*factorLeft/factorRight,
			geometry.HeightPX,
			geometry.HeightMM,
			geometry.XOffsetPX,
			geometry.YOffsetPX,
			output,
		),
		fmt.Sprintf(
			"xrandr --setmonitor virtual-right %d/%dx%d/%d+%d+%d none",
			geometry.WidthPX-(geometry.WidthPX*factorLeft/factorRight),
			geometry.WidthMM-(geometry.WidthMM*factorLeft/factorRight),
			geometry.HeightPX,
			geometry.HeightMM,
			geometry.XOffsetPX+(geometry.WidthPX*factorLeft/factorRight),
			geometry.YOffsetPX,
		),
	}

	err = execute(commands)
	if err != nil {
		log.Fatal(err)
	}
}

func findByStr(lines []string, search string) string {
	for _, line := range lines {
		if strings.Contains(line, search) {
			return line
		}
	}
	return ""
}

func parseGeometry(str string) (Geometry, error) {
	var geometry Geometry
	var err error

	fields := strings.Split(str, "+")
	dimensions, x, y := fields[0], fields[1], fields[2]

	geometry.XOffsetPX, err = strconv.Atoi(x)
	if err != nil {
		return geometry, err
	}
	geometry.YOffsetPX, err = strconv.Atoi(y)
	if err != nil {
		return geometry, err
	}

	fields = strings.Split(dimensions, "x")
	width, height := fields[0], fields[1]

	fields = strings.Split(width, "/")
	widthPX, widthMM := fields[0], fields[1]
	geometry.WidthPX, err = strconv.Atoi(widthPX)
	if err != nil {
		return geometry, err
	}
	geometry.WidthMM, err = strconv.Atoi(widthMM)
	if err != nil {
		return geometry, err
	}

	fields = strings.Split(height, "/")
	heightPX, heightMM := fields[0], fields[1]
	geometry.HeightPX, err = strconv.Atoi(heightPX)
	if err != nil {
		return geometry, err
	}
	geometry.HeightMM, err = strconv.Atoi(heightMM)
	if err != nil {
		return geometry, err
	}

	return geometry, nil
}

func execute(commands []string) error {
	for _, command := range commands {
		fmt.Println(command)
		fields := strings.Fields(command)
		err := exec.Command(fields[0], fields[1:]...).Run()
		if err != nil {
			return err
		}
	}
	return nil
}

type Geometry struct {
	WidthPX   int
	WidthMM   int
	HeightPX  int
	HeightMM  int
	XOffsetPX int
	YOffsetPX int
}
