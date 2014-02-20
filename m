From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Thu, 20 Feb 2014 05:17:25 +0100
Message-ID: <530581D5.4040507@alum.mit.edu>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home> <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com> <xmqqy51dirjs.fsf@gitster.dls.corp.google.com> <20140215085355.GA15461@lanh> <xmqqha7wfdld.fsf@gitster.dls.corp.google.com> <20140218193520.GB1048@serenity.lan> <xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 05:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGL4u-0001er-0N
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 05:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbaBTERe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 23:17:34 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59415 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294AbaBTERd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 23:17:33 -0500
X-AuditID: 1207440d-f79d86d0000043db-64-530581dc7f61
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 10.D6.17371.CD185035; Wed, 19 Feb 2014 23:17:32 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4415.dip0.t-ipconnect.de [79.221.68.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1K4HRP4030429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Feb 2014 23:17:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsUixO6iqHunkTXY4M0cNYuuK91MFg29V5gt
	bpzfxWqxZUczq0X3lLeMFv1LO9gc2Dx2zrrL7nH20QNmj0OHOxg9Ll5S9jjb3MTm8XmTXABb
	FLdNUmJJWXBmep6+XQJ3xpt7M9kLHotV7Lvzmb2B8YBQFyMnh4SAicTiQ/uZIWwxiQv31rN1
	MXJxCAlcZpT4+PorO4Rzjkni1fJl7CBVvALaEj/PTGMCsVkEVCX6tt1kBLHZBHQlFvU0g8VF
	BYIlVl9+wAJRLyhxcuYTMFtEQE1iYtshFpChzALHGCUuLvwBtlpYwEPiz4MlrBDbHjFJrFjx
	DizBKWAtcW/JYSCbA+g+cYmexiCQMLOAjsS7vgfMELa8xPa3c5gnMArOQrJvFpKyWUjKFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQIiQneHYz/18kcYhTgYFTi4WW4
	yhIsxJpYVlyZe4hRkoNJSZT3UR5rsBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXp5MoBxvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYLXFhj7QoJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgKI4vBsYxSIoHaK8KSDtvcUFiLlAUovUUoy7H7bZfnxiFWPLy
	81KlxHnv1wMVCYAUZZTmwa2AJcBXjOJAHwvzaoGM4gEmT7hJr4CWMAEt8drLCLKkJBEhJdXA
	KPtxffn1vRU/eUXtX068zNJjI3QovcO3ZBfTo5Umn01UbDxvqlvr2QSnMHmy7r2s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242425>

On 02/18/2014 08:51 PM, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
>> There's already the arbitrary set of prefixes in
>> refs.c::prettify_refname() and refs.c::ref_rev_parse_rules().  I can see
>> how a user might think that since "git log refs/heads/name" is
>> equivalent to "git log master" then "git branch refs/heads/name" should
>> be equivalent to "git branch name".
> 
> Not quite, I am afraid.  Branch names used for "git branch <name>"
> and "git checkout <name>" are like the Lvalue of an assignment, as
> opposed to extended SHA-1 expressions to express any commit
> (e.g. 'master^0', 'refs/heads/master', or 'master') that correspond
> to the Rvalues used in an expression.  Because "git checkout" can
> take a branch name or an arbitrary commit object name, there needs a
> way for the users to disambiguate.
> 
> Saying that "git checkout refs/heads/name" must be equivalent to
> "git checkout name" is like arguing that assignment "value+0 = x"
> should be valid because "value+0" is a valid value.

Your logic is impeccable...and yet the user's logic is also quite
reasonable.  I fell into this trap when I started using Git, and so did
most (all?) of my colleagues.

I think the problem is partly caused by the visual and semantic
similarity between references and Unix pathnames.  For pathnames, the
file that is called "filename.txt" in my current context has an
unambiguous, canonical name that might be "/home/mhagger/filename.txt".
 My first mental model of Git references was that "branch" and
"refs/heads/branch" are synonyms, and that the latter is somehow the
"unambiguous" and "canonical" way to write it.  I think this mental
model is what led me to make the universal beginner's mistake

    git branch refs/heads/mybranch

It took me a while to figure out how to fix the situation, and the whole
experience was very frustrating.

I wonder whether we could give a way to specify a reference in an
unambiguous, canonical fashion like I expected, for example by using a
leading slash: "/refs/heads/mybranch".  This could be a way for the user
to ask for DWIMming to be turned off without having to resort to
plumbing commands like update-ref.  This wouldn't necessarily solve the
problem, but it would at least lead the new user to type

    git branch /refs/heads/mybranch

instead of the ambiguous command above, which Git could either accept or
reject in good conscience rather than having to speculate about what the
user *really* meant.  I think that supporting absolute reference names
like this would also be useful for scripts, which otherwise probably
often have subtle failure modes if the user has defined reference names
that are ambiguous, modulo DWIM, with the reference that the script
intended.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
