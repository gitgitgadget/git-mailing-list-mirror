From: Mike Hommey <mh@glandium.org>
Subject: Re: Is it possible to configure the color of git diff outpyut
Date: Fri, 17 Jul 2009 19:45:29 +0200
Message-ID: <20090717174529.GB2925@glandium.org>
References: <3b9893450907170935k53baf50fue84fe619624a4489@mail.gmail.com>
 <7vbpnj5k2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: n179911 <n179911@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 20:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRsCw-0001xr-59
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 20:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbZGQSaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbZGQSaq
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 14:30:46 -0400
Received: from vuizook.err.no ([85.19.221.46]:54843 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbZGQSap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 14:30:45 -0400
X-Greylist: delayed 2736 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2009 14:30:45 EDT
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1MRrUT-0006lj-6N; Fri, 17 Jul 2009 19:45:03 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1MRrUv-0000ni-HE; Fri, 17 Jul 2009 19:45:29 +0200
Content-Disposition: inline
In-Reply-To: <7vbpnj5k2l.fsf@alter.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123480>

On Fri, Jul 17, 2009 at 09:51:46AM -0700, Junio C Hamano wrote:
> n179911 <n179911@gmail.com> writes:
> 
> > When I do git diff, for example, it has color output (red for "-" and
> > green for "+").
> > Can you please tell me how can I change the color used?
> 
> Can you please tell us what resources you consulted to figure this out
> yourself before asking your question on this list?  I am not complaining;
> I am trying to see how a "typical" user finds information on our software,
> so that we can potentially optimize our documentation set to make it
> easier to find answers to common questions.

I think it would make sense to have reference to configuration items
that have a special impact on commands in their manual pages. Or at
least a "See Also" section mentioning "git-config".

Mike
