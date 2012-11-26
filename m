From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [RFC/PATCH] Option to revert order of parents in merge commit
Date: Mon, 26 Nov 2012 18:24:11 -0500
Message-ID: <20121126232411.GB3937@pug.qqx.org>
References: <20121123083550.GA702@camk.edu.pl>
 <7vfw3zzoye.fsf@alter.siamese.dyndns.org>
 <20121126124200.GA29859@camk.edu.pl>
 <7v8v9otfdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td82R-0008Fs-RA
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab2KZXYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:24:14 -0500
Received: from pug.qqx.org ([50.116.43.67]:35219 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab2KZXYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:24:12 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id CD1FB1D326; Mon, 26 Nov 2012 18:24:11 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8v9otfdy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210514>

At 09:58 -0800 26 Nov 2012, Junio C Hamano <gitster@pobox.com> wrote:
>Kacper Kornet <draenog@pld-linux.org> writes:
>> The change of order of parents happens at the very last moment, so
>> "ours" in merge options is local version and "theirs" upstream.
>
>That may be something that wants to go to the proposed commit log
>message.  I am neutral on the "feature" (i.e. not against it but not
>extremely enthusiastic about it either).

That should also be included in the (currently nonexistent) 
documentation of the proposed option.
