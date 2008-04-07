From: "Kai Hendry" <hendry@aplixcorp.com>
Subject: Re: Integration branching
Date: Mon, 7 Apr 2008 19:18:45 +0100
Message-ID: <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
	 <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JivwP-0007pc-Gy
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 20:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYDGSSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 14:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYDGSSy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 14:18:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:44500 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbYDGSSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 14:18:53 -0400
Received: by yw-out-2324.google.com with SMTP id 5so254279ywb.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2008 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EsWRsmT+RgxbsUU3Py5AmmwpyVgM0qfYW9SW72RsewY=;
        b=lavihi4li7AxpD+v/j0kWDdmnStflzGfZuI2ZsuD9V8cLmlJQFzEqFZJ6Y4kEy5dJBAKqgV0/aLBxvg8FAwncpruW49Cik81yjxHT8UHZ6JvWUnhmbmrSKiG1TH+3I7Ij5Tcumorm6vsQSdNzzg9kzR4lWqHiwoZFQy/EjdbtEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FwOLL8AFzDQFGgQgICDvaLM34SMIgk8N6Qacltmf1PdF54nbj/SoceH/yO8mb3Xxw+Bwo+KFdUMepU89Q4B6/n14LLrwkkwvXCdEmrQPC49xF3aovI1cMbEknf+/bWnkuhPBZraM27ORj7rwgvN1AkCfRYg9+MKl44ypT4hntVw=
Received: by 10.114.150.1 with SMTP id x1mr6324521wad.109.1207592325871;
        Mon, 07 Apr 2008 11:18:45 -0700 (PDT)
Received: by 10.114.136.13 with HTTP; Mon, 7 Apr 2008 11:18:45 -0700 (PDT)
In-Reply-To: <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: de220af0ca1fdb29
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78984>

On Mon, Apr 7, 2008 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  A set of big questions is how that git.webvm.net/srv/git/webkit-test
>  repository was prepared, what its history look like and how it relates to
>  the history your repository has.  I presume that that is different from
>  the repository you are pushing from (which is "x61:aplix/test/WebKit"
>  repository), but other than that you did not give any details to guess
>  further.

webkit-test was just a `git --bare init --shared` and completely empty
with I tried pushing (publishing) the changes to WebKit trunk.

With thanks,
