From: Kirill Likhodedov <klikh.list@gmail.com>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 20:57:28 +0400
Message-ID: <52E83BE7-8D1C-4A9C-AA86-DBC58435C299@gmail.com>
References: <loom.20120125T173801-500@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 18:04:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq6Gg-0006OL-6v
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 18:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2AYREN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 12:04:13 -0500
Received: from mail1.intellij.net ([46.137.178.215]:56380 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab2AYREN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2012 12:04:13 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jan 2012 12:04:12 EST
Received: (qmail 25820 invoked by uid 89); 25 Jan 2012 16:57:30 -0000
Received: by simscan 1.1.0 ppid: 25775, pid: 25812, t: 0.0806s
         scanners: regex: 1.1.0
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 25 Jan 2012 16:57:30 -0000
In-Reply-To: <loom.20120125T173801-500@post.gmane.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189114>

Most likely, you  didn't update the PATH well enough.
Check what is the output of 'which git' command. It will point to the x=
code installation. So please double check the path.

25.01.2012, =D7 20:45, freefly:

> Hi all,
>    I am new to Mac OS X lion and I had a previous installation of XCO=
DE 4.2
> on my mac mini. It has a git version 1.7.5.4. I installed a new versi=
on 1.7.8.4.
> and updated the Path variables by running the script comes with the=20
> package as well. but when I type "git --version" in the terminal=20
> I get 1.7.5.4. Can anyone tell me what is going wrong ?
>=20
> Kind regards
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
