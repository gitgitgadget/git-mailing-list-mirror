From: Charles Bailey <charles@hashpling.org>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 08:14:38 +0000
Message-ID: <20090129081438.GA10490@hashpling.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSS4G-0006me-3M
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbZA2IOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbZA2IOl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:14:41 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:43980 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317AbZA2IOl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 03:14:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAI/0gEnUnw6U/2dsb2JhbADKcIQOBg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.ptn-ipout02.plus.net with ESMTP; 29 Jan 2009 08:14:39 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LSS2p-0007T0-KI; Thu, 29 Jan 2009 08:14:39 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0T8Ecgv011151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Jan 2009 08:14:38 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0T8EcAj011150;
	Thu, 29 Jan 2009 08:14:38 GMT
Content-Disposition: inline
In-Reply-To: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 5e847454a0c7636e03e04fb587e4140c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107643>

On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:
> * cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
>  + mergetool: respect autocrlf by using checkout-index
> 

Can you hold off on merging this one? I now think that there's a
cleaner way of doing this and I would like the opportunity for a
rethink.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
