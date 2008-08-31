From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] for-each-ref: new 'refshort' format
Date: Sat, 30 Aug 2008 21:31:34 -0700
Message-ID: <7vmyiterfd.fsf@gitster.siamese.dyndns.org>
References: <36ca99e90808291121j7b202917r2308719970668be3@mail.gmail.com>
 <1220046116-23703-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: szeder@ira.uka.de, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 06:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZecQ-0008BU-3I
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 06:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbYHaEbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 00:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbYHaEbs
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 00:31:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYHaEbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 00:31:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BC8C57D59;
	Sun, 31 Aug 2008 00:31:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8BD1957D58; Sun, 31 Aug 2008 00:31:37 -0400 (EDT)
In-Reply-To: <1220046116-23703-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Fri, 29 Aug 2008 23:41:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B61C0314-7715-11DD-86BC-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94452>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Here is a first sketch for this idea.
>
> This strips from the refname the common prefix with the matched pattern.

Looks quite straightforward and to the point.
