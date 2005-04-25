From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 19:13:59 +0200
Message-ID: <20050425171359.GN10806@cip.informatik.uni-erlangen.de>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org> <426D21FE.3040401@tiscali.de> <20050425171234.GP24187@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ78A-0005t6-CY
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVDYRQC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVDYRPq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:15:46 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:17090 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262691AbVDYROG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:14:06 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3PHE0S8013265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 17:14:00 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3PHDxHB013264;
	Mon, 25 Apr 2005 19:13:59 +0200 (CEST)
To: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mail-Followup-To: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050425171234.GP24187@lug-owl.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Yeah, "register" is what you use after 21 days of programming
> pracitce...

actually it is introduced on day 2.

	Thomas
