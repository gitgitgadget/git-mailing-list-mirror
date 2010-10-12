From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: OT: This forum
Date: Mon, 11 Oct 2010 17:29:04 -0700 (PDT)
Message-ID: <m3sk0cdzkn.fsf@localhost.localdomain>
References: <loom.20101012T012512-764@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Oct 12 02:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Sjz-0004qq-NT
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 02:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab0JLA3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 20:29:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab0JLA3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 20:29:07 -0400
Received: by fxm4 with SMTP id 4so768304fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 17:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=IEizrEk+ovumjOLL5KEcvrWVrqRzH6q7xkTVH6NQYdg=;
        b=N5iX1l+39B0mPmv/SRBQmJS8j4WBciOuisLj7hRTqc9NGtiXq2hMnv91fHVzX2h+bh
         +cr6xBRynQlmM5Ztt0dXqNQvo2W42aw21Lxbax70obHa0N81+848bfzWKENBut7yZns2
         DKBwZ0CuK8enTU96ayf2c/YJ0aBXMyXjoo4Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EBJmg7o7ceedVh/jidYmOHhhOEfW7TxIz61UwUWLPRdM9OPmLFcpwbSWFJctUO/Ad7
         gOhrzO7Bn+M1d+FhJrbUg9F2rDcmVOJApsYjxwWli2SrML8p7DGAbbizS9+yDbv3ySdQ
         Nua1MUhdYAfQFsxDm0txU+xGU3xDMc3xexVmg=
Received: by 10.223.102.143 with SMTP id g15mr1433991fao.110.1286843345023;
        Mon, 11 Oct 2010 17:29:05 -0700 (PDT)
Received: from localhost.localdomain (abwu155.neoplus.adsl.tpnet.pl [83.8.244.155])
        by mx.google.com with ESMTPS id a7sm3452776faa.21.2010.10.11.17.29.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 17:29:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9C0SeBc023803;
	Tue, 12 Oct 2010 02:28:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9C0SOsK023798;
	Tue, 12 Oct 2010 02:28:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20101012T012512-764@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158816>

Maaartin <grajcar1@seznam.cz> writes:

> I read this forum using
> http://post.gmane.org/post.php?group=gmane.comp.version-control.git
> and it sort of works. Except that finding own old posting is quite impossible, 
> even when I try searching for the subject, and/or author, and/or pieces of text 
> in any combination. It finds some posting, but it misses others, whatever I do. 
> Except that I don't know how to attach a file. Except that I'd expect to see a 
> thread containing a new reply somewhere on the first page instead of on the 
> 14th. Except that replies to emails I get (answers to my threads) goes to their 
> author instead of to the forum.
> 
> Is there a better way for using this forum/mailing list? However, I'd like to 
> avoid getting daily dozens of emails.

I personally read git mailing list (and reply) using GMane's NNTP
interface.  

You can read postings using any Usenet news reader, for example Gnus
from GNU Emacs / XEmacs, or KNode from Kontact, ory any mail client
supporting Usenet, using news.gmane.org as server, and subscribing to
gmane.comp.version-control.git (it is described on Gmane).  Those news
readers usually support threading.

But please remember to reply via email, and rather not cut Cc list.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
