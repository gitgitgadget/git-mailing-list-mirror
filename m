From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: Usability of git stash
Date: Sun, 19 Oct 2008 17:08:19 -0400
Message-ID: <ee2a733e0810191408m2cbe1ba5n540ad0fb99b49708@mail.gmail.com>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
	 <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>
	 <86vdvsg4up.fsf@lola.quinscape.zz>
	 <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil>
	 <87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Anders Melchiorsen" <mail@cup.kalibalik.dk>,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"David Kastrup" <dak@gnu.org>
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 13:49:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrfWo-00025j-9T
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYJSVIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYJSVIW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:08:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:40122 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYJSVIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:08:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1641539fkq.5
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K6mQmGknzlb2BzriFQ12weqSI+AbfkmRbLg6E4v6Qww=;
        b=sM9geI44Y98Omy24cOt40lZZI3zw02EFWhUM1XUTxJdkEXSarCl5Ma3IOlPYHa9veN
         pACGbdjZt7IHQxLW8lTFwIsNlrXUHWVEuTvBYQpl9Fc1WqvocfJN86G/ngDSad5P0Kto
         PvYedX+rYXB9yAi8jrcImZ1rE4phBYXMvjKqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=TdjbPmOFLxftCClAI5A0SQSbjVK2xHccc5zqMO4+BiSDFNq3QMj9GV4s/MWzM7bpBt
         ijBB2m6CG/2x1U1QrcWmYgAjW1Im7tpeDY+L/qzQkmzLzZaHmmeBLq1e59emISoXkxxr
         hvVmgBcp9bd1OwZWsWVFzkkPI7kS0O7V/2R/Y=
Received: by 10.187.163.5 with SMTP id q5mr1044972fao.44.1224450499134;
        Sun, 19 Oct 2008 14:08:19 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 19 Oct 2008 14:08:19 -0700 (PDT)
In-Reply-To: <20081019184029.GF14786@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98656>

On 10/19/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> [..snip..]
> Indeed, that's an advantage of the wip commit approach, you can shove
>  the untracked files quickly into the wip commit, especially with 1.6:
>
>         git commit -A -m wip
>
> [..snip..]

What version of git are you using?
I am using git-1.6.0.2 on Linux and "-A" is illegal option for "git commit"

--Leo--
