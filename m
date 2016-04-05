From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Tue, 5 Apr 2016 21:15:44 +0200
Message-ID: <57040EE0.40503@kdbg.org>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
 <1459802325-22056-2-git-send-email-alex@fournova.com>
 <xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:15:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anWSA-0001Rm-8x
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcDETPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2016 15:15:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55265 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbcDETPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 15:15:49 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qfdqP6dPyz5tlJ;
	Tue,  5 Apr 2016 21:15:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6096E5230;
	Tue,  5 Apr 2016 21:15:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290802>

Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>

I sense NFD disease: The combining diaresis should combine with the o,=20
not the g. Here is a correct line to copy-and-paste if you like:

Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>

-- Hannes
