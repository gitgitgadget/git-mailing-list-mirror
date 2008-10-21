From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Tue, 21 Oct 2008 09:56:28 -0700
Message-ID: <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 21 18:58:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsKYP-0004bo-Bd
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 18:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYJUQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYJUQ4p
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 12:56:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYJUQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 12:56:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 00E567064D;
	Tue, 21 Oct 2008 12:56:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B95EE70646; Tue, 21 Oct 2008 12:56:35 -0400 (EDT)
In-Reply-To: <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
 (Leo Razoumov's message of "Tue, 21 Oct 2008 06:23:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C312922-9F91-11DD-8C44-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98797>

"Leo Razoumov" <slonik.az@gmail.com> writes:

> Even though the old behavior is "long established", it introduces
> unnecessary ambiguity. If I have two repos
> ...

Of course.  Now you know why people don't name such a pair of repositories
like that ;-).
