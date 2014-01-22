From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and
 up arrows.
Date: Wed, 22 Jan 2014 22:04:48 +1100
Message-ID: <20140122110448.GB7306@iris.ozlabs.ibm.com>
References: <20131008193618.GE9464@google.com>
 <1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
 <52DE932E.7090008@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 12:08:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5vfT-0004OG-TU
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 12:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbaAVLIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 06:08:15 -0500
Received: from ozlabs.org ([203.10.76.45]:54458 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbaAVLIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 06:08:12 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 14D0B2C00AF; Wed, 22 Jan 2014 22:08:11 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <52DE932E.7090008@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240819>

On Tue, Jan 21, 2014 at 10:33:02AM -0500, Marc Branchaud wrote:
> On 13-12-18 11:04 AM, Marc Branchaud wrote:
> > Users often find that "next" and "prev" do the opposite of what they
> > expect.  For example, "next" moves to the next match down the list, but
> > that is almost always backwards in time.  Replacing the text with arrows
> > makes it clear where the buttons will take the user.
> 
> Any opinions on this, either way?
> 
> I've grown fond of the down/up arrows.  I find them much clearer than the
> current next/prev buttons.
> 
> My only niggle about this patch is that the buttons are much smaller,
> requiring a bit more precision clicking.  But the smaller buttons allow more
> room for other widgets.

I showed it to a few colleagues who use gitk a lot.  One was
indifferent, the others liked it, so I have applied it.

Thanks,
Paul.
