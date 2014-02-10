From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 1.9.0 round 2
Date: Mon, 10 Feb 2014 13:08:06 -0800
Message-ID: <xmqqtxc6r809.fsf@gitster.dls.corp.google.com>
References: <CANYiYbGV7aPd300Bwkm9yWAZR-crtk8Jk2TCckuGvkmrQGe+rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 22:08:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCy5g-0004b3-B8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 22:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbaBJVIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 16:08:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394AbaBJVIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 16:08:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF186B6EB;
	Mon, 10 Feb 2014 16:08:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vIPDEiX4uCZCf2R0KY6SI0qTLk4=; b=Kt+95/
	752jCymIO+UTf+PBrqwQ1bHxqfqNQrjLsBATCUvoEd3QO7zlY/ZQlv6PvU/jjzb/
	mlYeEXerV060lBpjup3EgJ0y58rmJD22bGcwBeE9DBHZT5rwSJ2di4RCFJGfPdqK
	XgjsvnDcS+gE2R4t/jIDWnzzJEfGundpp6b0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRumXLvFM7dL5lfYQYfCRWcw7lNMDFAn
	2mMWzQ9yhxWIIWFCGGiWXJrbSzE33Cpl+AsPXnaSumQySOVlpyKQGzX3AS6RC8/3
	nn+92ghI0lzkbpekBoIiHfoeS82k0Vx+Ot4sLet6T1Xbb7k5/flmSY0G95FKrHQP
	PJVWlQRcyzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1057B6B6EA;
	Mon, 10 Feb 2014 16:08:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D35DE6B6E7;
	Mon, 10 Feb 2014 16:08:08 -0500 (EST)
In-Reply-To: <CANYiYbGV7aPd300Bwkm9yWAZR-crtk8Jk2TCckuGvkmrQGe+rQ@mail.gmail.com>
	(Jiang Xin's message of "Sat, 8 Feb 2014 08:01:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 714C3ED6-9297-11E3-96E2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241931>

Thansk.
