From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: cvsimport: rewritten in Perl
Date: Sun, 03 Jul 2005 15:44:47 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.03.13.44.46.995524@smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be> <20050703122110.GC18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 03 15:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp4nF-0007ao-C0
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 15:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGCNpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 09:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGCNpp
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 09:45:45 -0400
Received: from main.gmane.org ([80.91.229.2]:23223 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261440AbVGCNph (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 09:45:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dp4mZ-0007WS-Iq
	for git@vger.kernel.org; Sun, 03 Jul 2005 15:45:15 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jul 2005 15:45:15 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jul 2005 15:45:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Sven Verdoolaege wrote:

>> http://www.liacs.nl/~sverdool/git.git#cvs2git
> 
> That was a cogito branch, btw.
> In git you'd say:
> 
> git-http-pull -c -v -t -a heads/cvs2git http://www.liacs.nl/~sverdool/git.git/
> 
Your patches make sense -- thanks; imported.

Linus: Please grab http://netz.smurf.noris.de/git/git.git/#cvs2git.

(A very git-ty URL, that.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Quantum Mechanics is God's version of "Trust me."
