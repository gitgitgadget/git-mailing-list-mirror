From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and
 up arrows.
Date: Thu, 23 Jan 2014 22:08:48 +1100
Message-ID: <20140123110847.GA12814@iris.ozlabs.ibm.com>
References: <20131008193618.GE9464@google.com>
 <1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
 <52DE932E.7090008@xiplink.com>
 <20140122110448.GB7306@iris.ozlabs.ibm.com>
 <xmqqa9enydm4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 12:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6I9i-0000p1-Do
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 12:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbaAWLI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 06:08:59 -0500
Received: from ozlabs.org ([203.10.76.45]:53722 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbaAWLI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 06:08:58 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 51E4A2C00A0; Thu, 23 Jan 2014 22:08:57 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqa9enydm4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240908>

On Wed, Jan 22, 2014 at 12:18:27PM -0800, Junio C Hamano wrote:
> Is this a good time for me to pull from you?  I see these on your
> 'master' branch.
> 
>     8f86339 gitk: Comply with XDG base directory specification
>     786f15c gitk: Replace "next" and "prev" buttons with down and up arrows
>     c61f3a9 gitk: chmod +x po2msg.sh
>     6c626a0 gitk: Update copyright dates
>     45f884c gitk: Add Bulgarian translation (304t)
>     1f3c872 gitk: Fix mistype
> 
> Thanks.

Yes, please pull.  I have just pushed one more:

	76d64ca gitk: Indent word-wrapped lines in commit display header

Thanks,
Paul.
