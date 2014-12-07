From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: How to repair a shallow clone (?)
Date: Sun, 07 Dec 2014 18:53:30 +0100
Message-ID: <5484941A.4040300@web.de>
References: <5482F55F.1060008@web.de> <CACsJy8DshPJreCDOUYWO90E9jsDVe8XO_jVjMCcC=DV8EK6N5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 18:53:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxg1a-0002nC-1S
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 18:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbaLGRxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 12:53:33 -0500
Received: from mout.web.de ([212.227.17.11]:62251 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaLGRxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 12:53:33 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LvSPv-1XpfjN49Fz-010fQo; Sun, 07 Dec 2014 18:53:31
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8DshPJreCDOUYWO90E9jsDVe8XO_jVjMCcC=DV8EK6N5Q@mail.gmail.com>
X-Provags-ID: V03:K0:UmANlg6qfW5LuGB0of6U0NdhlcqXBlpn/KEnSsJn2rvEBvSrd0D
 70Nvq29j6ZkACW6otB2W3MX2WDSP7wdyLYk0W6LzKgbeIdBI0nk4lfrVbkM1QGHCJT8EkK9
 W3byyu9nZ+eAPZ+gBEu84opyLWS5wqv3w3MzMYIMRpnWFWZ0Ci79Qx7YZLXR/jl5xPVCT1g
 7+V27MBdw1c0RmC3yEeyQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260993>

On 2014-12-07 12.44, Duy Nguyen wrote:
>> Is this a known issue/problem ?
> 
> No.
> 
Thanks everybody for the support.

The machine was equipped with git version 1.7.10.4 in /usr/bin.

I installed 2.1 or so under /usr/local/bin, (and even /root/bin) 
thinking that this would help, but it didn't.

Because the login shell for the user "storage" which manages the push/pull
on the server side was /usr/bin/git-shell, not /usr/local/bin/git-shell.
