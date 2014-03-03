From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Mon, 03 Mar 2014 11:37:54 +0100
Message-ID: <87ppm3lg8t.fsf@fencepost.gnu.org>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-4-git-send-email-pclouds@gmail.com>
	<CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com>
	<CAPig+cS8XRf8LzajSJL7LVxVKb_cqLviwSimYyYXRWL46dh9QA@mail.gmail.com>
	<53145523.7020900@alum.mit.edu>
	<CACsJy8DQz-74QJCOq8O7pZG3BwsyzoLhayxmALv6LjaFYWP4YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:38:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQGB-0002Ch-3s
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbaCCKiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:38:06 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49213 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbaCCKiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:38:04 -0500
Received: from localhost ([127.0.0.1]:48249 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKQG3-00054J-MJ; Mon, 03 Mar 2014 05:38:03 -0500
Received: by lola (Postfix, from userid 1000)
	id 2F656E065B; Mon,  3 Mar 2014 11:37:54 +0100 (CET)
In-Reply-To: <CACsJy8DQz-74QJCOq8O7pZG3BwsyzoLhayxmALv6LjaFYWP4YQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 3 Mar 2014 17:15:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243218>

Duy Nguyen <pclouds@gmail.com> writes:

> Logically, yes. Practically, no. If you have to put multiple -e and
> some hashes in one line, wouldn't editing to-do list in your favorite
> editor be faster?

An editor is the last resort when the card puncher is broken.

-- 
David Kastrup
