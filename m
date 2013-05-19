From: Antony Male <antony.male@gmail.com>
Subject: Re: .gitignore behavior on Mac
Date: Sun, 19 May 2013 11:54:36 +0100
Message-ID: <5198AF6C.8080402@gmail.com>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com> <20130518184136.GH27005@serenity.lan> <CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com> <20130518185507.GI27005@serenity.lan> <5197EC19.8080806@kdbg.org> <CAEe6bfC6F3sN_OXZYo1=bdwo01_7qFUEmbSWVFNaFZQrZUGdWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Lauri <peterlauri@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1Lu-0006GD-9l
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab3ESLA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:00:29 -0400
Received: from avasout06.plus.net ([212.159.14.18]:34941 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3ESLA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:00:29 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 May 2013 07:00:28 EDT
Received: from [192.168.1.64] ([80.229.240.47])
	by avasout06 with smtp
	id dmuP1l001123hEw01muQgh; Sun, 19 May 2013 11:54:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=YbCEuWhf c=1 sm=1 tr=0
 a=IPa1ga7gUYoitdfonedwDw==:117 a=IPa1ga7gUYoitdfonedwDw==:17 a=0Bzu9jTXAAAA:8
 a=wTpUH-9xXWAA:10 a=UiP0-A_bWJoA:10 a=nDghuxUhq_wA:10 a=8nJEP1OIZ-IA:10
 a=pGLkceISAAAA:8 a=wzgwQMKkgHwA:10 a=NEAV23lmAAAA:8 a=riJpwzZhb-eEu-r70uUA:9
 a=wPNLvfGTeEIA:10
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAEe6bfC6F3sN_OXZYo1=bdwo01_7qFUEmbSWVFNaFZQrZUGdWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224847>

On 18/05/2013 23:37, Peter Lauri wrote:
> Great, I have gotten the concept now :)
>
> My workaround for my problem is to rename the file to ....default and
> then all will work out well :) Copy the file then and locally modify
> it, but it will be in .gitignore so not tracked :)

Over in the #git IRC channel, we point users asking this question to 
https://gist.github.com/canton7/1423106. It contains that approach, and 
quite a few others.

Antony
