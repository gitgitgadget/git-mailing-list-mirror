From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: the war on trailing whitespace
Date: 27 Feb 2006 07:22:33 -0800
Message-ID: <86wtfgzv0m.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	<94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
	<4402E56D.4010606@op5.se>
	<20060227133124.GA8794@informatik.uni-freiburg.de>
	<4403086F.5040704@op5.se>
	<20060227143147.GA12196@brainysmurf.cs.umu.se>
	<Pine.LNX.4.63.0602271539160.4371@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Hagervall <hager@cs.umu.se>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 16:28:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkCx-0006fK-1g
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 16:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWB0PWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 10:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWB0PWk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 10:22:40 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:46236 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751341AbWB0PWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 10:22:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B4F428F6F3;
	Mon, 27 Feb 2006 07:22:33 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 16076-02-4; Mon, 27 Feb 2006 07:22:33 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 374158F7CE; Mon, 27 Feb 2006 07:22:33 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.1.11; tzolkin = 11 Chuen; haab = 9 Kayab
In-Reply-To: <Pine.LNX.4.63.0602271539160.4371@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16852>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Exactly. That is what Andreas is saying: if you change a line which 
Johannes> consists only of trailing whitespace to an empty line, it breaks python 
Johannes> (or formatting).

[insert standard rant about Python treating invisible things significantly,
which is the prime counter-rant to people saying Perl looks like line noise]

[chuckling]

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
