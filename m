From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 18:34:55 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100411223455.GA16622@thyrsus.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
 <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com>
 <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234>
 <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com>
 <d0869259b375a26df46ef92a2b973615@212.159.54.234>
 <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com>
 <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 00:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O15kP-0004bJ-7O
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 00:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0DKWe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 18:34:56 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:49198
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab0DKWez (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 18:34:55 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 279C320CD3D; Sun, 11 Apr 2010 18:34:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144691>

Jon Seymour <jon.seymour@gmail.com>:
> [ And, yes, I understand that to making line-oriented formats a
> backend would be a reasonably invasive change to existing code that
> would involve a level of indirection and abstraction that may not be
> to everyone's taste. ]

For whatever my opinion is worth I think this is a good direction to
go in.  I think it fits the well-established git design philosophy of
separating content manipulation (plumbing) from presentation
(porcelain).
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
