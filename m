From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 22:22:56 +0100
Message-ID: <4766E8B0.6050507@free.fr>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>  <fk2juf$t25$1@ger.gmane.org>  <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>  <fk2p0f$961$1@ger.gmane.org>  <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>  <fk2q1f$bbh$1@ger.gmane.org>  <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>  <fk3153$rtb$1@ger.gmane.org>  <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>  <fk5grp$7il$2@ger.gmane.org> <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com> <Pine.LNX.4.64.0712171911070.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NQy-0008Ky-13
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbXLQVXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759223AbXLQVXA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:23:00 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:39181 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760672AbXLQVW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:22:59 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5F0FD1AB338;
	Mon, 17 Dec 2007 22:22:58 +0100 (CET)
Received: from [192.168.0.1] (gre92-5-82-237-199-162.fbx.proxad.net [82.237.199.162])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 153D61AB2AD;
	Mon, 17 Dec 2007 22:22:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712171911070.9446@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68625>

Johannes Schindelin wrote:
> Hi,
>
> On Mon, 17 Dec 2007, Marco Costalba wrote:
>
>   
>> On Dec 17, 2007 10:51 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
>>     
>>> I would like to help you with that but I can't retrieve the repository:
>>>
>>> $ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
>>> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
>>> git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
>>> git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
>>> git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
>>> git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
>>> fatal: unable to connect a socket (Bad file descriptor)
>>> fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.
>>>       
>
> This looks familiar.  It happens when there was no response to the 4 IPs 
> of git.kernel.org.  This might be due to a firewall which blocks git://
>   
Yes, I guess this is the issue. I'll try from home now and report back. 
In any case I managed to clone the qgit4 repository from 
http://repo.or.cz/r/qgit4.git already so I can work from here.

Abdel.
