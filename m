From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] graph API: avoid printing unnecessary padding before
 some octopus merges
Date: Sun, 01 Jun 2008 21:41:11 -0700
Message-ID: <7vod6ka1p4.fsf@gitster.siamese.dyndns.org>
References: <20080529085752.GA31865@adamsimpkins.net>
 <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
 <1212353818-7031-2-git-send-email-adam@adamsimpkins.net>
 <1212353818-7031-3-git-send-email-adam@adamsimpkins.net>
 <7vskvwakph.fsf@gitster.siamese.dyndns.org>
 <20080602000441.GA9291@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 06:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K31sB-0004iO-KO
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 06:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYFBEl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 00:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbYFBEl1
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 00:41:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYFBEl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 00:41:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2157C2168;
	Mon,  2 Jun 2008 00:41:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8064E2167; Mon,  2 Jun 2008 00:41:19 -0400 (EDT)
In-Reply-To: <20080602000441.GA9291@adamsimpkins.net> (Adam Simpkins's
 message of "Sun, 1 Jun 2008 17:04:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 270D6A30-305E-11DD-9F1E-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83485>

Adam Simpkins <adam@adamsimpkins.net> writes:

> How do you prefer to fix simple things like this?  Do you want to just
> apply the fix yourself, or is it easier for you if I submit an amended
> patch?

For a small thing like this, it's probably easiest if you said: "Yeah, use
that phrasing" (or "It would be even better to say this way: ...") would
be good enough.  I know how to operate my editor ;-).
