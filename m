X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: Adding spell checker to GIT
Date: Wed, 13 Dec 2006 01:21:50 +0530
Message-ID: <b5a19cd20612121151g74bae55fjd022b6314ffcf6c8@mail.gmail.com>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
	 <200612051726.kB5HQO2t015777@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 19:52:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DOypltENmMBOZ2jT3Pvf3HOr1Q52h0MrE5a2MPhMHrTv5x0H8KvYGN3tL5unjD4PY+ia09aRIHxVs5d0ZQRGCM/REiz+x+VwCCz9ioYXlVNrYd0hzVuJLLMYNCH9h/QlHzMqA6xv4ve4bvtvkHzh07GTkA2GRishEO+qj6JObyY=
In-Reply-To: <200612051726.kB5HQO2t015777@laptop13.inf.utfsm.cl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34140>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuDfh-0005lu-WC for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932420AbWLLTvw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWLLTvw
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:51:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:53112 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932416AbWLLTvv (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 14:51:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so325543nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 11:51:50 -0800 (PST)
Received: by 10.49.64.18 with SMTP id r18mr1760751nfk.1165953110073; Tue, 12
 Dec 2006 11:51:50 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Tue, 12 Dec 2006 11:51:50 -0800 (PST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Hi Mr Brand,
                  what you are suggesting seems fine to me but the
thing is should i write a GIT plugin where cani get info to write
one...?

Regards
Deepak



On 12/5/06, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Deepak Barua <dbbarua@gmail.com> wrote:
> >         I am just thought of a idea to integrate a spell checker with
> > git so that when we check in the code the code comments are spell
> > checked before being put into the tree,maybe have a optimized
> > dictionary search.
> > what about this...? is it appropriate ...?
>
> An external tool that spellchecks your code would certainly be nice, but
> I'd vote against integrating it into git (or any other tool for that
> matter). git doesn't care if what is being saved is C code, Malebolge, or a
> collection of dirty pictures. And that is 100% fine with me. Don't kill
> this, it is one of the fundamental Unix strengths.
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                    Fono: +56 32 2654431
> Universidad Tecnica Federico Santa Maria             +56 32 2654239
> Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
>
>


-- 
