From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast importer for SCCS files
Date: Sun, 20 Jan 2008 22:27:25 -0800
Message-ID: <7v7ii33d82.fsf@gitster.siamese.dyndns.org>
References: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
	<7vsl0s57e8.fsf@gitster.siamese.dyndns.org>
	<buo7ii3pvwb.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "James Youngman" <jay@gnu.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 07:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGq8i-0002ek-1a
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbYAUG1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 01:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbYAUG1n
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:27:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYAUG1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 01:27:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DBBA73F6A;
	Mon, 21 Jan 2008 01:27:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 777313F69;
	Mon, 21 Jan 2008 01:27:37 -0500 (EST)
In-Reply-To: <buo7ii3pvwb.fsf@dhapc248.dev.necel.com> (Miles Bader's message
	of "Mon, 21 Jan 2008 14:53:08 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71227>

Miles Bader <miles.bader@necel.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> You seem to be using a tab-width that is not 8, and it shows
>> everywhere.
>
> In a python script, too...

We already seem to have two .py file under contrib/ and I do not
particularly mind scripts written in Python in contrib/ area.
