From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 13:57:59 -0500
Message-ID: <535ab03711d81_471d7d930822@nysa.notmuch>
References: <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <535a9f375e196_3984aa530c46@nysa.notmuch>
 <20140425182459.GA29329@sigill.intra.peff.net>
 <535aa905cd59c_44cee6530ccb@nysa.notmuch>
 <20140425185731.GA31454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:08:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlUB-0004Sy-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbaDYTIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:08:30 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36801 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbaDYTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:08:27 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so4686854oag.13
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zGpj3p1KU/GQa/LSvzXT+UmLIB+IWy655Iyhrm5MNgE=;
        b=xKoRSqEG/7jhdojEjL48suvqwc6BnLlA/G+WNlgLWTWyZxXsEMp8ienrDoJAPeYlhv
         CuwfnDUe5OVlD/rT4WmmuStQQIECBFklNkzh1wLW1yfQlywGDDRScJO8YHLtCUrwVbZs
         DFVTN+inrM3CMZpcFsnpARUxSJL8zYeOuyxqA1djqqrYIsKxGwiDadpzjGiCHAP6dZuL
         bcsjoVTyTTy5pQZqdKOx1salyMGeYfeOJzQwgnEaqzclpHCi+OYq8+9GGfqI2N2mKzyr
         ebpOao28+DWHESYv3cbw/ElBHmO4wXxXHFEBSYeYXudla+wwaocJf/f16pN4MvQhrIYO
         bPxg==
X-Received: by 10.60.37.199 with SMTP id a7mr8375010oek.41.1398452906796;
        Fri, 25 Apr 2014 12:08:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j9sm17266965obh.23.2014.04.25.12.08.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 12:08:25 -0700 (PDT)
In-Reply-To: <20140425185731.GA31454@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247098>

Jeff King wrote:
> On Fri, Apr 25, 2014 at 01:27:17PM -0500, Felipe Contreras wrote:
> 
> > I specifically said everybody agreed to "move away from the name 'index'", I
> > didn't say everybody agreed on the "staged area" although the vast majority
> > did, and I didn't say anybody agreed on my patches, although some did.
> > 
> > I think I was clear.
> 
> Maybe I was not clear in my response, so let me try again. I do _not_
> necessarily agree that we need to move away from the name index.

So you agree that "the index" is a bad name, and you agree "staging area" is a
better name, yet you don't agree we should move away from the term "index"?

-- 
Felipe Contreras
