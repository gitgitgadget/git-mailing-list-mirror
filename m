From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Pair Programming Workflow Suggestions
Date: Wed, 16 Sep 2009 09:36:12 -0400
Message-ID: <c115fd3c0909160636k6ce7441m70ecf23247e4d7d0@mail.gmail.com>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com> 
	<m3zl8w2hpf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 15:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnugf-0003re-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 15:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701AbZIPNgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 09:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758185AbZIPNga
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 09:36:30 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:49397 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbZIPNg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 09:36:29 -0400
Received: by ywh10 with SMTP id 10so3584373ywh.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=5bYLCKnVwcFl33pXZREVcCH8xbDMTMQkbAy8iakLcVI=;
        b=PS9tH5WflXlQY3lq0yQ5Z9WBggjP8eQ51BmriIzX+qiVlbLje81f/3iByxh+jJlgLy
         ixGMDEB4ueHKt7e4TMfxyiYXJgspGnWLRAmLAtTeyrfV6G8Wqsef68U8vbvnm75enea8
         YDxiCQMqpzEhp3ENHT8tiY+4BDl/qvoYYwo6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oobGOvXZCq7jHgaQQfjbYH9h5k6P8FC/oBp9YTaHqhZZR9UzMBvWL9dkAJOghlPpkL
         Vh2RgN8HVWITEQYuRQ/DF+Lw+LZ9wspW2FXPR6BA57QV4XBP35QDAUKlFqWSxbqRkFqt
         0MNXgOjdt4+fRG+f9xKkFTZfO03bft9Z+0zDs=
Received: by 10.101.88.18 with SMTP id q18mr9029546anl.64.1253108192451; Wed, 
	16 Sep 2009 06:36:32 -0700 (PDT)
In-Reply-To: <m3zl8w2hpf.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128654>

On Tue, Sep 15, 2009 at 2:20 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Tim Visher <tim.visher@gmail.com> writes:
>
>> I'm interested in hearing how people use Git for pair programming.
>> Specifically, how do you document that you are programming in pairs.
>
> [...]
>
>> I did find Brian Helmkamp's script
>> http://www.brynary.com/2008/9/1/setting-the-git-commit-author-to-pair-programmers-names
>> but that's not really what I'm looking for. [...]
>
> I'm not sure if this would help you, but take a look at "Pair
> Programming & git & github & Gravatar & You & You" blog post by Jon
> "Lark" Larkowski from May 30, 2009:
>
>  http://blog.l4rk.com/2009/05/pair-programming-git-github-gravatar.html

Unfortunately my company firewall is blocking that post.  I'll have to
read it later.  Thanks for the pointer though!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
