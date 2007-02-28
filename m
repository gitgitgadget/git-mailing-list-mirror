From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Questions about git-rev-parse
Date: Wed, 28 Feb 2007 08:54:32 +0000
Message-ID: <200702280854.32440.andyparkins@gmail.com>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org> <20070228025258.GD2178@thunk.org> <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 09:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKa8-00072V-DP
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 09:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXB1Iyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 03:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXB1Iyi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 03:54:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:24032 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXB1Iyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 03:54:37 -0500
Received: by nf-out-0910.google.com with SMTP id o25so486867nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 00:54:36 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o+usM3KoaFeCXmeM28DdsWk0MmFp+rpx96qeeswf36OxiyddM0HVeAaKUtubRghzv0Rlzy1dGronDWz5Bw8v3Rk8bz/nQvmpeSoEKT9Cs8snWwAX5C+SYuMJZy9OPvTUpBz4uVzq4LVErxjdwyXnJJVih/HkwJ2Z2xKbUEce1a0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NhlL2i5E9g7x3bJVUcsRKfPU/4Kw72s8oLivuqr7OE8IIgwMa02PugRRFFVhdSFLZ5rfed+mRDjRy6L/GmuvD/wa1BFlEJDMX5AYfIaVT0lA8t6vzZX+auC/3RjN1fIhD/SFcovr/vT+oYz93kBKd48vWo/1LezrTVwfEHhmn8c=
Received: by 10.49.57.1 with SMTP id j1mr3157785nfk.1172652875999;
        Wed, 28 Feb 2007 00:54:35 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k24sm5032001nfc.2007.02.28.00.54.34;
        Wed, 28 Feb 2007 00:54:34 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40907>

On Wednesday 2007 February 28 03:33, Linus Torvalds wrote:

> So a "tree-ish" is not necessarily exactly a tree, but it has all the
> characteristics of a tree (by virtue of there being a well-defined 1:1
> relationship with a tree).

Funny; I'd always guessed that it came from Lord of the Rings, which (I think) 
often mentioned "Ent-ish" as being the language of the trees.  Then the happy 
coincidence of the English idiom usage meaning "approximately" was just a 
happy bonus.

Shocking: something geeky that didn't have an association with Lord of the 
Rings.  What will they think of next? :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
