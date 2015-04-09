From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.4.0 round 2
Date: Wed, 08 Apr 2015 21:18:13 -0700
Message-ID: <xmqqegnuaq9m.fsf@gitster.dls.corp.google.com>
References: <CANYiYbGubDKHgRP7VXLCdsOZ9_zVHDWfZ-QbJbjtApGq=H5Rvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
	<vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 06:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yg3v5-0006Ya-JU
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 06:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbDIESR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 00:18:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbbDIESQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 00:18:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7738748301;
	Thu,  9 Apr 2015 00:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTg6M9tyEzkrhuE1ryzdOKxRs2E=; b=HzcNIv
	Kx54/PhNuax3lfvjeaZ6VqWhjidqIhJgYTLdlj8y2F889sI1hLeSt+dd5t7NMUBg
	cq5XdA21uG/coKh6KX6D9qgqHsmTTHDRW3wFQ5tGOoc5q2mm/BRfTgaY+sUHYJBI
	DrjGrHBejp6tHTe4R4BWCnJzBLH5CgRFCnqc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jhZoj3MtzjLYDcKw9mdmmZo6zvGGVTbC
	umhIjBFbPc1w1gJnIvPT2bO9KRtVTmdGiuxUvJtde5we2CSqsNqbqPKWP8nqGas6
	ajca43kvKYQO+DXwsq0/2YaGoRIswB4t8e+8Z6/RvIb/Br/Fo4a4AHf6gThJglJo
	mamKA9ES9Lo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E43E48300;
	Thu,  9 Apr 2015 00:18:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D78FB482FF;
	Thu,  9 Apr 2015 00:18:14 -0400 (EDT)
In-Reply-To: <CANYiYbGubDKHgRP7VXLCdsOZ9_zVHDWfZ-QbJbjtApGq=H5Rvw@mail.gmail.com>
	(Jiang Xin's message of "Thu, 9 Apr 2015 08:33:32 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7130D748-DE6F-11E4-B675-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266984>

Thanks, all.
