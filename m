From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Mon, 25 Aug 2008 22:33:56 +0200
Message-ID: <4d8e3fd30808251333p1e49b9dan2a6e74ee4f7facb1@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXimE-0004Ro-R1
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYHYUd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbYHYUd5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:33:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:50905 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbYHYUd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:33:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2011245wfd.4
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GM6hV4LTsMScpeEdOk7a7fKHg4k74IwivyZ+z0t9b7w=;
        b=ekWwCHt0MnI4QvISzidNAn0VXkgfSftLTysbcBkMECptMUcrfde1o5F2XPSjF59MnO
         jqfUX/hwTQU4mJkRiTS0wg5wrr6CSRGMJIBbroi6CShwUc8yX2/bHM6kdybgtzdzSdXH
         UEAlGd0CmBxkcLSAY/dGceo00PDbrr3AOU+BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A6QD+23pQCWpuGA6WUd5DhthIJQF6EtD/CwVCsfFLKbw2mgnEl6qdpsZ5JqF01XhQC
         JUGy+pqbo85+GFH0RpPn909OU7fOBx7raikoZSrr31PeL+AmpA8/0b2D3FUi8tiQNOzw
         64iT3Sx7rRpW0WWGT+3b7vgnpm75lL6nMTLd0=
Received: by 10.142.139.14 with SMTP id m14mr1690239wfd.207.1219696436325;
        Mon, 25 Aug 2008 13:33:56 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Mon, 25 Aug 2008 13:33:56 -0700 (PDT)
In-Reply-To: <loom.20080825T200956-169@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93670>

On Mon, Aug 25, 2008 at 10:12 PM, Eric Raible <raible@gmail.com> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi <at> gmail.com> writes:
>
>> +Alice can also use gitk to browse that Bob did:
>
> s/that/what/ ?

Yes!

>> +------------------------------------------------
>> +alice$ gitk master origin/master
>> +------------------------------------------------
>
> I think that you meant:
>
> alice$ gitk master..origin/master
>
> right?

Well, I thought gitk master origin/master would be sufficient.
Guess I'm wrong...

Cheers,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
