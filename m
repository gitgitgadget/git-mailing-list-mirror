From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 12:03:51 +0530
Message-ID: <c94f8e120812282233i3783cf65o5ad9663e079e7fd6@mail.gmail.com>
References: <gj7mmo$fvk$4@ger.gmane.org>
	 <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
	 <gj96pl$885$4@ger.gmane.org>
	 <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sitaram Chamarty" <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 07:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHBid-0007ln-0G
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 07:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYL2Gdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 01:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYL2Gdx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 01:33:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:14938 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYL2Gdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 01:33:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1475140ywe.1
        for <git@vger.kernel.org>; Sun, 28 Dec 2008 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pvLHiVSKrcw6l1dt514drCGJ6NiOLvZwEVt3asx3niQ=;
        b=NgSRVXsac/n5eEGGoEuDqKyeIlCHGs+zgBRHBst3lhpKDeZOMDarrn8fUW2DWduX+O
         Bq1MCqlLZ3cF8/GTy7Qhry9ojLMKZyaHRUO/06ETG3FgC5HYKZreMA11TSGnyubyQiEb
         prSkCKrXyZFD9b9jc+fX/8ArsdaN2iMyI3AGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xwzV6oHzYJVSISDRpEEWQWQGlYX0IwxuvCS7q8oeDd6Lj8B1cdJJVPanEB/HzWMpwS
         7sp8A55wfWobcghuRd8A2CivMBmaBkNzA1onaqQX64T6z5DAWox+vGejDdckZk4TNZwh
         zYf3yADp8iV7Hw0Tr2lWxwF2jQT4juV44xq9o=
Received: by 10.100.137.12 with SMTP id k12mr7508320and.55.1230532431534;
        Sun, 28 Dec 2008 22:33:51 -0800 (PST)
Received: by 10.100.142.5 with HTTP; Sun, 28 Dec 2008 22:33:51 -0800 (PST)
In-Reply-To: <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104073>

On Mon, Dec 29, 2008 at 6:42 AM, <sitaramc@gmail.com> wrote:
> On 2008-12-29, Zorba <cr@altmore.co.uk> wrote:
>> Hi Sitaram!
>>
>> Thanks for clearing that one up.
>
> you're welcome; we've all done a bit of struggling I guess!
>
>> Also, I did wonder about HEAD and head. One can move, the other
>> doesn't!  (well, acually it does - head moves "forward", as the tip
>> of the branch grows)
>
> Here's an extract from my notes/internal talks on this:
>
>    === basic concepts      * a branch is "an active line of
> development"      * //master//: default branch in a project, by
> convention      * //head//: tip of a branch      * a repo can track
> many branches, but the working tree is associated with        only one
> branch at a time      * //HEAD//: tip of the branch associated with
> the working tree; this is        where commits go        ** except
> when it's "detached"

That's a nice,compact and effective  note. Thanks for sharing :-)
Consider pushing the full notes to GITHUB...would be _useful_ for all of
us..(like me)...


-- dm
