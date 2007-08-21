From: Mike Hommey <mh@glandium.org>
Subject: Re: a475e8095aeb898c1ca60673b82df97d2300cc95 broken for docs
Date: Tue, 21 Aug 2007 23:45:05 +0200
Organization: glandium.org
Message-ID: <20070821214505.GA12678@glandium.org>
References: <86odh0ojx4.fsf@blue.stonehenge.com> <7vsl6coahd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INbYd-0002NI-0f
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbXHUVqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 17:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXHUVqg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:46:36 -0400
Received: from vawad.err.no ([85.19.200.177]:32785 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbXHUVqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 17:46:35 -0400
Received: from aputeaux-153-1-97-232.w86-217.abo.wanadoo.fr ([86.217.119.232] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INbYJ-0003lV-5G; Tue, 21 Aug 2007 23:46:19 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INbX7-0003Im-HO; Tue, 21 Aug 2007 23:45:05 +0200
Content-Disposition: inline
In-Reply-To: <7vsl6coahd.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56334>

On Tue, Aug 21, 2007 at 02:15:26PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I think we've seen it reported that docbook-xsl 1.72 and/or 1.73
> are broken.  Is your debug log from either of these versions?

The problems brought by docbook-xsl 1.72 are from a different nature.
Also note they only make a problem with the output, and don't break the
build.

Mike
