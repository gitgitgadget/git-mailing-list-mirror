From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 12:12:08 -0500
Message-ID: <537100e8b6682_222d129730829@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
 <5370a47bee98c_139611a92fc29@nysa.notmuch>
 <5370B920.2060506@alum.mit.edu>
 <5370beb4b2483_168f13a72fc57@nysa.notmuch>
 <87mwenuond.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 19:23:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjtwV-00077E-Iu
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 19:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759020AbaELRXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 13:23:07 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33292 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaELRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 13:23:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so8719886oag.12
        for <git@vger.kernel.org>; Mon, 12 May 2014 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Qksesdfcad8pT5TNUQOlhuYbHP7tk1cCV8UQCIhSqi8=;
        b=J/5tJpFWhn5sEHeyk3bK1rZUKMbqCze65eCFi1aF80WhuXTAEFZ+MSdDW7cLhLuH0N
         6NbGiDFkqwCCQkXSqG9GSl/PC+qRaKjvPyCDufgKbOuzso1gIZliAG4akDBGa16f6Fto
         15tHuy/FDdZuOFIT2Eb0mZxFCh0DBo+yete9hF84rJ+ILlMhSWujOl/0wTJY6FFTFUwG
         HOarhAKLy+X5q/lalpk0vAiCfqvci6KeCuYjveBTXEz6IsHwoqOqU5OvD1f9tD1Nn1To
         70gk0J6wixJIDLZmSfWVL2v9T8WykBJ5ghq5lu4oAuDV3xehGxbGp9+k8uZRDIRfWvCS
         Busw==
X-Received: by 10.60.155.72 with SMTP id vu8mr6062297oeb.60.1399915384013;
        Mon, 12 May 2014 10:23:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm50759049oej.5.2014.05.12.10.23.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 10:23:03 -0700 (PDT)
In-Reply-To: <87mwenuond.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248713>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Then there's no point in reading what else you have to say. Whatever
> > reasons you might have to agree with Junio are known only to you, thus
> > your "agreement" is opaque and meaningless.
> 
> Let me spell it out for you.  Michael states "I agree with Junio.  There
> are good technical arguments for and against moving git-remote-hg out of
> contrib."  Since there are arguments for both sides, the decision boils
> down to a judgment call.  Michael states that he condones the choice
> Junio made, based on the reasoning he gave.

Junio didn't give any reasoning, he deferred by saying "that reason some
other guy gave" and he never explained which reason that was.

Which is why I'm pretty sure Michael Haggery does not have actually any
reason.

He even admitted almost as much by saying he doesn't really care much
about these "small technical issues", which are not important to him.

So until Michael explains his reasons, I'll assume he has none. And so
should any rational person.

-- 
Felipe Contreras
