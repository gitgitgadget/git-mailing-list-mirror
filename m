From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 00:58:15 -0700
Message-ID: <7vr6lhpkh4.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRkLh-0000wm-PK
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXIBH6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 03:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbXIBH6U
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 03:58:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbXIBH6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 03:58:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A17E412CD10;
	Sun,  2 Sep 2007 03:58:38 -0400 (EDT)
In-Reply-To: <46DA5F33.2020005@zytor.com> (H. Peter Anvin's message of "Sun,
	02 Sep 2007 07:58:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57304>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>>
>> * For people who need to import from Perforce, a front-end for
>>   fast-import is in contrib/fast-import/.
>
> There seems to be an issue with this and RPMS.
>
> In particular, there is no longer a git-p4 RPMS, which prevents git
> from getting upgraded at all by yum.
>
> Anyone who knows yum well enough to explain what needs to be done so
> that yum knows this is obsolete?

Geez.  Is this only about upgrading, or is initial install also
affected?
