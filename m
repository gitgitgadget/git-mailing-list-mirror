From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: parsecvs has been salvaged
Date: Fri, 11 Jan 2013 14:02:29 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130111190229.GB30398@thyrsus.com>
References: <20130111112151.AFF924047B@snark.thyrsus.com>
 <CAA6gtpnDrVOfiX-bQFS2X91wsS705b60YST8DwuDaibjkYU9vg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Keith Packard <keithp@keithp.com>
To: Bart Massey <bart@cs.pdx.edu>
X-From: git-owner@vger.kernel.org Fri Jan 11 20:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttjsb-0001w5-HB
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 20:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab3AKTCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 14:02:41 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41633
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab3AKTCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 14:02:41 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id A5DDC4047B; Fri, 11 Jan 2013 14:02:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAA6gtpnDrVOfiX-bQFS2X91wsS705b60YST8DwuDaibjkYU9vg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213235>

Bart Massey <bart@cs.pdx.edu>:
> Very cool! I'm glad you got it doing what you wanted; I'll be
> interested to see how parsecvs compares in quality and performance to
> cvs2git and cvsps. --Bart

And now it has that -R option and correctly interprets the timezone field.
(I've been busy this morning.)  I'm working on the no-commitids warning now.

Oh, and it now has...actual documentation, too. :-)
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
