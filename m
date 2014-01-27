From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: remote author/documentation sections from more pages
Date: Mon, 27 Jan 2014 08:05:37 -0800
Message-ID: <xmqqha8ppfzi.fsf@gitster.dls.corp.google.com>
References: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu>
	<CAPig+cQ3w-VrjbgwgSMCRovR+P27f8GignyYG+bKic4RZEc5Gw@mail.gmail.com>
	<52E5B86E.2060708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 27 17:05:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7oh2-0001Ah-FW
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 17:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbaA0QFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 11:05:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131AbaA0QFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 11:05:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 693C567BB5;
	Mon, 27 Jan 2014 11:05:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnoSpv6YbT2dkGuRFMni0IEq3WM=; b=DI6Jyx
	kTV7MUWfg9/I+lE2BUIQpPKCjBrKEKfhpB7ifMDVK1LPA3PyYavelC0TiShxRiSz
	HDjceNR5BlX6piYMCaaLghltvGwZJ91GZVZY21Ecp5E2hNLXnQdZ13IywsZoIz5t
	BRHnEmHUzw/gbI8EyaUUZtDQ7oZ/NjQNnmAps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZHqU5FmHZg3bdV2ISzOfWE0o1q1zsFr
	2EbOBKx7MwMq7TQVwzUqO2MJBYvApdUwvHHlqjxtDAJeh7w9ZmCGDEfGrgxi+jls
	fJHkbBxrqN4i0WW7G6jgdvFAM1y7UzL5h6mn+YdsAYtNI5NxqZcl7t1mrC4gRENf
	4U9BuRdNy7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544A067BB4;
	Mon, 27 Jan 2014 11:05:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D92167BB1;
	Mon, 27 Jan 2014 11:05:40 -0500 (EST)
In-Reply-To: <52E5B86E.2060708@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 27 Jan 2014 02:37:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE1ECD84-876C-11E3-B20E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241144>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/27/2014 01:15 AM, Eric Sunshine wrote:
>> On Sun, Jan 26, 2014 at 6:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Subject: [PATCH] doc: remote author/documentation sections from more pages
>> 
>> s/remote/remove/
>
> Gaah!  Git is a virus that invades your muscle memory and prevents you
> from typing words that are similar to git subcommands.
>
> Thanks for noticing.
>
> Michael

Thanks; s/remote/remove/ will be done on this end; no need to
resend.
