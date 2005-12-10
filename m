From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/25] Usage message clean-up
Date: Sat, 10 Dec 2005 23:50:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512102349040.3083@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 23:51:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElDYJ-0002aE-Nn
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 23:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVLJWut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLJWus
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 17:50:48 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32915 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751276AbVLJWur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 17:50:47 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BFAA213F9C0; Sat, 10 Dec 2005 23:50:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A58F39DCCB; Sat, 10 Dec 2005 23:50:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 93A6E9DCBF; Sat, 10 Dec 2005 23:50:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F07613F9C0; Sat, 10 Dec 2005 23:50:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: freku045@student.liu.se
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13476>

Hi,

On Sat, 10 Dec 2005, freku045@student.liu.se wrote:

> * Any unrecognised options should make the script die with the usage
>   message.

Good.

> * -h and --help makes the script die with the usage message.

Good.

> * The message is printed to stderr.

Arguable.

> * The message is of the form "usage: $0 options"

Not good. We are in a transition to "git whatever" from "git-whatever".

Besides, I have to admit that I am a bit annoyed by 25 mini mails for the 
same purpose.

Hth,
Dscho
