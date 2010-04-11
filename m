From: Eric Raymond <esr@thyrsus.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured
 output
Date: Sun, 11 Apr 2010 16:57:04 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100411205704.GA16098@thyrsus.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
 <20100411113733.80010.3767.julian@quantumfyre.co.uk>
 <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
 <91d4c9c4ecdd32166bedb6dc0bd007d6@212.159.54.234>
 <m3y6gtg24x.fsf@localhost.localdomain>
 <aae50060001ba0a214ed71ceff3fa480@212.159.54.234>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O14DW-0002bO-0L
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab0DKU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 16:57:08 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:38737
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0DKU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 16:57:07 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id D9F6220CD3D; Sun, 11 Apr 2010 16:57:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <aae50060001ba0a214ed71ceff3fa480@212.159.54.234>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144684>

Julian Phillips <julian@quantumfyre.co.uk>:
> That should be much easier.  Though actually I am fairly close to getting
> _all_ output from ls-tree going through the output library ... (i.e. even
> the normal no-option output).  I don't know what people's opinion on this
> approach is, but I thought it was worth a try anyway.

I make encouraging noises in your direction.  This approach sounds
like an orthogonality and consistency win.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
