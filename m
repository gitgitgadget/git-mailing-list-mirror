From: "Matthew Andrews" <matthew.andrews@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 17:23:52 -0500
Message-ID: <3a5d78af0710141523u4330a0fcnbc76a6b18354181e@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <853awepyz6.fsf@lola.goethe.zz>
	 <8fe92b430710141449r3f1b1a85oae2a5fb5b30c8b47@mail.gmail.com>
	 <85k5ppjqfu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhBsV-0005sx-F6
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbXJNWX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757663AbXJNWX4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:23:56 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:10672 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbXJNWXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:23:55 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1283699rvb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OhSJwESN6bfq4jRwCswNjHxN0Tgoa4YvIGpkCN5lRS4=;
        b=QnRPy9EtCTqeSGj0AYoMSL38BdkGwVuvAet4f8nSuGdJHj6j0rkC1twOJiJ2cSuNOS1L1sGTVsj6opGaG8dm4i3oQ/MdYRM1z6sPFunKUsZn8eIH969e85brMJubCL52qDsLzfVnKX7+GL+LRdhjMx70f9r+t4xH+XVXBmHRjis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mTHYC/MGvCBWZUpHlUXxk5vnVE42Ub91WskB7OrfBT3GapegGG/Ml4paNmOqQUTa4kpNC2rESsEEYEsKhntdbkPbjxQb6SB/Ff2/+i06nryAYVx0SHEOJDZK5nCc/IEN/S3hb11EKmjXgD+5YAGe9V2BJzc6ngucWytXoKFVJWQ=
Received: by 10.142.125.5 with SMTP id x5mr1340945wfc.1192400633026;
        Sun, 14 Oct 2007 15:23:53 -0700 (PDT)
Received: by 10.143.161.17 with HTTP; Sun, 14 Oct 2007 15:23:52 -0700 (PDT)
In-Reply-To: <85k5ppjqfu.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60919>

I'm trying to see this negative tone that apparently exists on the
list. As a long-time lurker, I only see a fairly standard open-source
expectation of basic knowledge and strong opinion. The list is fairly
good about point people to existing documentation. If you do something
that somebody thinks is stupid, they'll tell you so. They don't coddle
you here, but they are more than willing to help.

On 10/14/07, David Kastrup <dak@gnu.org> wrote:
> "Jakub Narebski" <jnareb@gmail.com> writes:
>
> > On 10/13/07, David Kastrup <dak@gnu.org> wrote:
> >
> >> I find it a pity that my suggestion to ask about how comfortable
> >> people are with the tone on the list did not make it into the survey.
> >> Enough core developers make the tone sufficiently unconstructive to
> >> make it quite understandable that people are unwilling to ask
> >> questions here, in order to avoid getting their heads banged against a
> >> wall, virtual or not.
> >
> > I think next to last question in the survey
> >
> >  61. Did you have problems getting GIT help on mailing list or on
> >  IRC channel?  What were it? What could be improved?
> >
> > was the place to put complaints about git mailing list.
>
> What if there are no problems getting help once you submit to letting
> your head get bashed in?
>
> The problem is not with getting help on the list: the list is
> bristling with competent people.  The problem is the price to pay in
> self-esteem and comfort.
>
> --
> David Kastrup, Kriemhildstr. 15, 44793 Bochum
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
