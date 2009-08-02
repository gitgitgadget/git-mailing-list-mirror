From: Aaron Cohen <remleduff@gmail.com>
Subject: Re: [OT] git and clojure
Date: Sat, 1 Aug 2009 22:53:10 -0400
Message-ID: <727e50150908011953g19c7b8f2u4f348e3605c2bcf1@mail.gmail.com>
References: <f46c52560908010918t5ff0d97cxe638f9f8eb5a5b40@mail.gmail.com>
	 <46a038f90908011456q34cc8834tcb9db81d22653b06@mail.gmail.com>
Reply-To: aaron@assonance.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Aug 02 04:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXRCd-00008K-Rw
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 04:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbZHBCxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 22:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHBCxL
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 22:53:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43722 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZHBCxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 22:53:10 -0400
Received: by bwz19 with SMTP id 19so1869373bwz.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 19:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:cc:content-type
         :content-transfer-encoding;
        bh=qQSSssKuQ0I3MlxI4o/2kVG5KVig0C1jcFBO4fyBUi0=;
        b=NdvRimMdtGPotkY5eLY/0pklriHrEpXyhmWO0DLkQxRXUBDA3G8zNzaoNf6X1Aj7Jd
         60Z9YCfxPruttGz1iza9peYUCE/AwguBMuV5ianiPvRyAmZeMrE52GGIdwkJYIDWNrOc
         Q8HbAeA3WSq1DK4dtpay4wdLOX2Hdt6MEvFJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:cc:content-type:content-transfer-encoding;
        b=BujOGpALWxPxoJyR2UzFD09CwrZ1iu+ilcIoiI+4SQhMa9Z4IDZ8/exlql3LL5l/As
         72k63WKMa0etOhryVU9tu0LY0oi9tLR1k9XXMFK9qGb/oIxi35d4d5/841CkXswhlSee
         ZLU3Lecepv8x3dbPXBF9cahF635ZuCmqRX5k8=
Received: by 10.204.60.212 with SMTP id q20mr2471824bkh.200.1249181590048; 
	Sat, 01 Aug 2009 19:53:10 -0700 (PDT)
In-Reply-To: <46a038f90908011456q34cc8834tcb9db81d22653b06@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124659>

They're both based on immutable data structures.  Other than that, you'=
ve
got me.  Come to think of it, Clojure did fairly recently switch to usi=
ng
git and is now hosted on github, so it might be an artifact of that.
-- Aaron

On Sat, Aug 1, 2009 at 5:56 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
>
> On Sat, Aug 1, 2009 at 10:18 AM, Rustom Mody<rustompmody@gmail.com> w=
rote:
> > Any ideas about the link between git and clojure?
>
> About the same as Debian and dueling banjoes.
>
>
> m
> --
> =C2=A0martin.langhoff@gmail.com
> =C2=A0martin@laptop.org -- School Server Architect
> =C2=A0- ask interesting questions
> =C2=A0- don't get distracted with shiny stuff =C2=A0- working code fi=
rst
> =C2=A0- http://wiki.laptop.org/go/User:Martinlanghoff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
