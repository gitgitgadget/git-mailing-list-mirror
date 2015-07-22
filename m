From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v5] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 22 Jul 2015 22:48:52 +0200
Message-ID: <20150722204852.GB11291@ikke.info>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
 <1436046158-19426-1-git-send-email-me@ikke.info>
 <xmqqd205yq98.fsf@gitster.dls.corp.google.com>
 <20150707035956.GA6105@yoshi.chippynet.com>
 <20150722190724.GA11291@ikke.info>
 <xmqqvbdcq8rq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI0wk-00048q-UA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 22:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbbGVUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 16:48:54 -0400
Received: from ikke.info ([178.21.113.177]:51918 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbGVUsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 16:48:54 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 69B974400AE; Wed, 22 Jul 2015 22:48:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqvbdcq8rq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23+89 (0255b37be491) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274467>

On Wed, Jul 22, 2015 at 12:42:17PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > On Tue, Jul 07, 2015 at 11:59:56AM +0800, Paul Tan wrote:
> >
> > Any news about this? Is it still waiting for something?
> 
> Paul's patch was buried in the noise and I didn't notice it.
> 
> I'd prefer to see a new feature like this, that did not exist in the
> original, be done on top of the "rewrite pull in C" topic, which
> will need a bit more time to mature and be merged to 'master'.
> 
> Thanks.

Ok, no problem.
