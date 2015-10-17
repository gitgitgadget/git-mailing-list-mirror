From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 0/4] stripspace: Implement and use --count-lines option
Date: Sat, 17 Oct 2015 12:27:43 +0200
Message-ID: <20151017102742.GA2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <xmqqsi5ag404.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 12:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnOis-0006I5-5U
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbbJQK1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:27:47 -0400
Received: from sym2.noone.org ([178.63.92.236]:54447 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbJQK1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:27:46 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ndLC44DHDzQWhr; Sat, 17 Oct 2015 12:27:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqsi5ag404.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279782>

On 2015-10-16 at 18:41:31 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> Be consistent with the subjects, please.
> 
> >   strbuf: make stripspace() part of strbuf
> 
> s/make/make/ ;-)
> 
> >   stripspace: Use parse-options for command-line parsing
> 
> s/Use/use/
> 
> >   stripspace: Implement --count-lines option
> 
> s/Implement/implement/
> 
> >   git rebase -i: Use newly added --count-lines option for stripspace
> 
> s/Use/use/

Will adjust all of them to lowercase for v3. Thanks.
