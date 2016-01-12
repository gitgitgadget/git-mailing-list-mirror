From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git doesn't save capitalization change in file names.
Date: Tue, 12 Jan 2016 10:58:16 +0100
Message-ID: <5694CE38.5020503@web.de>
References: <CAMkNX-K=GQ6LkZv2PS5Pfs+v2bN1ozi9P5ZN4Z60Ba-3JtuRkg@mail.gmail.com> <CAH5451=-RkyYs3UJHUvvYHSrNODzW4dmAQDHU_Jo-Wf4Oa7Dew@mail.gmail.com> <alpine.DEB.2.20.1601120900380.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniil S <ds98s3a@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 10:58:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIvie-0007MV-NV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 10:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbcALJ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 04:58:25 -0500
Received: from mout.web.de ([212.227.17.11]:53934 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933279AbcALJ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 04:58:23 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lpw6t-1ZevrX1XwF-00fixi; Tue, 12 Jan 2016 10:58:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <alpine.DEB.2.20.1601120900380.2964@virtualbox>
X-Provags-ID: V03:K0:7IT+u5tIIEUmweUX1AtzumOx7wTZFjLwlGJia4q6rsi4wzykd9k
 OOHZ2/EzehBr35mxHc1OwLd4C+dsFcEUuk+XojlhVyocmIFwEqlCwHvfuxGqvEvTBVM6eYn
 zs+q36L/fk8E+B9pGWe7BEK0MeTooJ/hunVf4AYWqjPhJKKrOH2rXFbEDIR6iAit+2H1dZi
 SaAJLGNRcxkKrVLtP2Y6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgVxo/Gm+JM=:v7WogYFWMtOneRcDpEDrV5
 cwoHGYj13BJ8xHFP0d0q4rYciiAMA+MQfM5wdBkn2Gnh3dBskhIuHQIpzdlQlNZJlkL4eHuON
 BRX5gVSttcMafz3or9wkyNTbnGAm9hpKbFU+0KVOZQ1LmxP8OvCM3gQmbiDq0P7r6hyyV+BmB
 e+y4gsGAh/qd+V0w2digjYa5xdTu0zQsK6rHVN0SAv6LM7hBUYbfgSypKL1yWDaIfkctcYA0w
 gxb7f0WmOAdpI8iZH9D7fzcynue4wjh1vlbFAm4PFjir9TREb71kqTDTO6BIfYjy1Lxo+kkki
 5LARnyEuJwHtsjWNwxmNEepiLt8VMn25H9MZgQFo9f8A7IjofbAnFF7faGJicC65T38jNBO6o
 VvIo8lPDdsKe/D5HyyL2I9vxYFHNhaarY8XrN9JxfUt3njJzSpw/vngEDMH/pNchBKMm0RH94
 k2FfaVQn/Lg0zw8Oi1D41qGbFGqSV3lqv7X4rRv36SucOkM5tWQ/hSVYna71KsXGBv4Nal87p
 2NSy6GbGqm4dQVNYpQj4J2D0h9+LVWlmrmvyZ+PqnjeJHgIbIBAF1+uxFqcgbclC61s0bkl/A
 0G1hH/u64srW6uHXosUeLI5k9EeB6mP104eVIrQnh2xV6RiT+4wJ7M2nfvW8A+10wdHlIf+MF
 AG6OznwKCt6vu1gX+y8jk5u7SfOHTTRa/6ZhRMYnGh0YfniuBkyh1MdsFelka68/O4kSaIpow
 KRevC7DPxoEihFN7xOgC3YtrIWjj7t7YGVGWvm0Zfc2VvKneDmZcVFIO1fLhw6I12iGM4jR0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283785>

On 01/12/2016 09:02 AM, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 12 Jan 2016, Andrew Ardill wrote:
>
>> On 12 January 2016 at 13:06, Daniil S <ds98s3a@gmail.com> wrote:
>>> So I've now encountered this with both GitHub and BitBucket, Windows
>>> and Linux versions, so I'm fairly sure it's git's fault.
> I highly doubt that the Linux variety of Git displays this problem, unless
> it is run on a case-insensitive file system.
>
>>> Example: if file named "Pathfinding.java" was renamed to
>>> "PathFinding.java" and that change is then committed, filename won't
>>> change in repository.
>> This actually comes down to the file system you use, as git itself does
>> keep track of the capitalisation of file names; if the file system is
>> case insensitive (Mac OSX being the typical example) then you can run
>> into weird issues when files change case.
>>
>> For example, the following two search results:
>>
>> https://stackoverflow.com/questions/10523849/changing-capitalization-of-filenames-in-git
>>
>> https://ocroquette.wordpress.com/2014/07/08/git-capitalization-of-file-names-and-name-conflicts/
> I'd like to offer the most common work-around:
>
> git mv Pathfinding.java Pathfinding.java.rename
> git mv Pathfinding.java.rename PathFinding.java
>

Side note: That should no longer be needed: new versions of Git can 
handle the rename these  days.

However, when A) does the rename, pushes it to a central repo,
B) pulls the changes, the file will stay un-renamed on the local disk.
You can delete all worktree files, and do a reset --hard, (at your own risk)
