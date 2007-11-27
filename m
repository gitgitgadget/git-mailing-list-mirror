From: Steven Grimm <koreth@midwinter.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:10:15 -0800
Message-ID: <83D4511B-BE07-4098-9901-44C164467F76@midwinter.com>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src> <AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com> <7vhcj8g0op.fsf@gitster.siamese.dyndns.org> <20071127010350.GE14735@spearce.org> <7v7ik4e4xa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>, Jan Hudec <bulb@ucw.cz>,
	David Kastrup <dak@gnu.org>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 06:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwsie-0002KZ-HJ
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 06:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbXK0FKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 00:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXK0FKR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 00:10:17 -0500
Received: from tater.midwinter.com ([216.32.86.90]:55397 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751155AbXK0FKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 00:10:16 -0500
Received: (qmail 16229 invoked from network); 27 Nov 2007 05:10:15 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=MbfUsMWajHAY7kxeIzoRyIW0Q0ocjX58IOmXqhhmshCcdD1DqQ4L/NVpngwZPSYf  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 27 Nov 2007 05:10:15 -0000
In-Reply-To: <7v7ik4e4xa.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66167>

On Nov 26, 2007, at 7:35 PM, Junio C Hamano wrote:
> Seriously, speaking I find this "negative" list ugly.  I am  
> wondering if
> it makes more sense to use positive "Porcelain" list, or perhaps even
> "The most commonly used" list from "git help" output.

Yes, a positive list makes much more sense. If for no other reason  
than that it will require the author of a new command to make a  
conscious decision before that command will be suggested to users.

-Steve
