From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 summary - git homepage improvements
Date: Wed, 17 Oct 2007 08:21:38 +0200
Message-ID: <8fe92b430710162321h5eed667fj3daf99701f328835@mail.gmail.com>
References: <8fe92b430710141505y75ab61c4l50688fc9530e4f90@mail.gmail.com>
	 <20071017011835.GH18279@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii2Hv-0005Qu-BZ
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbXJQGVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 02:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbXJQGVk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 02:21:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:34393 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbXJQGVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 02:21:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1654762rvb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L+E620CcZmStgN3jbhfhu6TIoUl8n7jHrkmElbBygzk=;
        b=TdCO3OBOptObXzPQVf7cJ57A1gHUlXxpUmpjLwpNE2RP4SSk9jkZB4NJz5C9BvNwoxcTMQLz6aDE/m3dtqoA+/GWWLyEux/SUNmHyP1tlpAzTTGWjJK4fuhNvV9Q0dz7OKUpPVPZo9Aa2dh67IJBWENF601oY9XXJLL2OHx+1H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qh6t0VmLp5fupxUMhMDyXeJE2HLqHAWpz9JHsAvm7AM+a53zjPfYmRvFCArVYFvENdJjPBuc9zestH18c1hQdIv5I2jnpWU+JC32t+XBVXwsNcWRbYfFN0kWRG4N+qrYIGCwtiQh72Lyw3+pHgNTfc90qo0CwcFSSoiJYfk1b2g=
Received: by 10.114.89.1 with SMTP id m1mr9435669wab.1192602098231;
        Tue, 16 Oct 2007 23:21:38 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Tue, 16 Oct 2007 23:21:38 -0700 (PDT)
In-Reply-To: <20071017011835.GH18279@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61336>

On 10/17/07, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Oct 15, 2007 at 12:05:22AM +0200, Jakub Narebski wrote:

>>  # Information about MS Windows version(s). Link to MSys Git, marking
>>    it as under development; perhaps plea for help?
>
> I'm not sure what in particular the MSys people want... They may want to
> send patches, though. ;-)
>
> Maybe we could merge the (largely artificially separated anyway)
> subproject subsections to a single alphabetically-ordered subsection and
> include MSysGit there?

I was thinking more about adding link to MSysGit / GitMe / WInGit in the
"Getting Git"/"Binaries" section. I'm not sure what people who put this response
in survey want...

>>  * Perhaps making some pages like FAQ or Tips and Tricks, or
>>    discussion about nature of branches in git taken from GitWiki when
>>    they are mature enough
>
> This touches a subject that I'm kind of surprised wasn't mentioned more,
> that is the homepage-wiki duality. Are people happy with the current
> setup? I kinda am, or would be if I got more patches. ;-) I'm personally
> not too fond of having project's main homepage in wiki -
> *especially* if it's made obvious by half of the screen space being
> occupied by wiki-generated metalinks. But if everyone else thinks that
> we should just move the main page to a wiki format, I won't stay in the
> way.
>
> I'd like to use this space to also repeat that I never seriously
> intended to maintain the technical side of the wiki, I've set up just
> because it was so damn easy. I have grown to just hate the wiki engine
> we use, and if someone wants to take the wiki over, you are welcome!

I'm very happy with homepage / wiki separation. IMVHO having wiki for
homepage is not a very good decision. I thought that wiki would be
more staging area for homepage, and that some content after maturing
would be put on homepage.

-- 
Jakub Narebski
