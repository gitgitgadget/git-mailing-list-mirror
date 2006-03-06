From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 6 Mar 2006 10:18:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603061016320.1422@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
 <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
 <20060306024353.GA23001@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:19:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBro-0003kR-VM
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbWCFJS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbWCFJS5
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:18:57 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:37036 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752327AbWCFJS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 04:18:57 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 30D0A1BC6;
	Mon,  6 Mar 2006 10:18:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 23C795EEA;
	Mon,  6 Mar 2006 10:18:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0890C1BC6;
	Mon,  6 Mar 2006 10:18:55 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060306024353.GA23001@mythryan2.michonline.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17288>

Hi,

On Sun, 5 Mar 2006, Ryan Anderson wrote:

> +use Data::Dumper;

You really need this?

Ciao,
Dscho

P.S.: Not to be left behind, I also weigh in into the other discussion: 
I'd like "git-{annotate,blame} [HEAD [--]] [filenames...]".
