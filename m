From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 20:03:56 -0400
Message-ID: <BAYC1-PASMTP08F9B6EA71E7C83DD93E8DAE080@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egrgqe$1i9$1@sea.gmane.org>
	<9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 02:04:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYtU9-0006lP-9H
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 02:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWJOAD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 20:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbWJOAD7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 20:03:59 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:7843 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1752291AbWJOAD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 20:03:59 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 14 Oct 2006 17:12:30 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GYsXt-0001yj-0L; Sat, 14 Oct 2006 19:03:57 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Message-Id: <20061014200356.e7b56402.seanlkml@sympatico.ca>
In-Reply-To: <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Oct 2006 00:12:30.0687 (UTC) FILETIME=[9AE93EF0:01C6EFEE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 Oct 2006 19:06:10 -0400
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> Top two git issues effecting Mozilla choosing it
> 1) some way to avoid the initial 450MB download

Why not split the repository up after you import it?  Break it into
two repositories, last year or two, and then everything else.

> 2) better windows support

Hard to imagine native windows support existing in time to be used by 
the Mozilla folks, maybe in time for 3.0 :o)

Sean
