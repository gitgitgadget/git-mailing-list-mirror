From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 14:31:24 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060227133124.GA8794@informatik.uni-freiburg.de>
References: <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net> <20060225210712.29b30f59.akpm@osdl.org> <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org> <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer> <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com> <4402E56D.4010606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 27 14:32:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDiTh-0000zj-Aq
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 14:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWB0Nb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 08:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWB0Nb1
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 08:31:27 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:2032 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751091AbWB0Nb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 08:31:26 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FDiTF-0002Dq-KU
	for git@vger.kernel.org; Mon, 27 Feb 2006 14:31:25 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k1RDVOSh009326
	for <git@vger.kernel.org>; Mon, 27 Feb 2006 14:31:24 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k1RDVOjt009325
	for git@vger.kernel.org; Mon, 27 Feb 2006 14:31:24 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4402E56D.4010606@op5.se>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16845>

Hello,

Andreas Ericsson wrote:
> I think the question is whether completely empty lines are also ignored 
> by Python, or if they start a new block of code. Whatever the case, it 
> must hold true for both 2.3 and 2.4.
see
	http://www.python.org/doc/2.2.3/ref/blank-lines.html
	http://www.python.org/doc/2.3.5/ref/blank-lines.html
	http://www.python.org/doc/2.4.2/ref/blank-lines.html

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=gravity+on+earth%3D
