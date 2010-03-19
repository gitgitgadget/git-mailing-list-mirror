From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: About single user setup for lightweights
Date: Fri, 19 Mar 2010 19:38:11 +0530
Message-ID: <2e24e5b91003190708y162f0ecfkeb00346aaa14d1e3@mail.gmail.com>
References: <87r5nht6uf.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bazaar@lists.canonical.com,
	mercurial@selenic.com
To: Harry Putnam <reader@newsguy.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:08:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nscs6-0007E3-1c
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab0CSOIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 10:08:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38543 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab0CSOIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:08:12 -0400
Received: by vws11 with SMTP id 11so414497vws.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uWQxYq95VERbSgWH340LdTYW93qSPz76AYdmtTdwZDk=;
        b=P5xzYSGjjeyabSk35k43LxG7myELWpCqgrJ5mrFdaFtKv4h9SezhLlR3pHvXb0P5hO
         YT+S5K0eWHY/jkVAplrl5oCDTfUttadArQwHL43a/lB5swAfsTb+5SaUckanV+abW4pn
         nR6bSP9+KWV5r+WI76Gj/f1Tp60+ULKcnARG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gl7UNY+ppB7DydX1aBow4aWi85i/+beTHB1aGB64Z6kQSrqdg9Fvbc5IUbqMtvJ6cI
         JQBkH+Ro6C7hekMSqzKbGuAHVJHP1k6GrF3/+ksB+R6VHuGbz+g7Fw2KeMb1xgxy4Sz5
         M/JylconC95XdSM4+jHO8HsBdJbJBmqHCf7Rk=
Received: by 10.220.107.22 with SMTP id z22mr1608787vco.63.1269007691415; Fri, 
	19 Mar 2010 07:08:11 -0700 (PDT)
In-Reply-To: <87r5nht6uf.fsf@newsguy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142596>

On Fri, Mar 19, 2010 at 7:23 AM, Harry Putnam <reader@newsguy.com> wrot=
e:

> I keep a central cvs repo and on each host I do a check out of the
> entire thing from the base up. =C2=A0Mostly to have copies of various=
 style
> of rc files the =C2=A0OSs need but also to keep the scripts I've writ=
ten
> over the years and learned to rely on, available and in sync.

about the most important thing, you ought to notice is that you don't
need to stay connected to your "server" to commit.  I do this too, and
having a DVCS (in my case, git) helps a lot.

I didn't, on a quick read, see that mentioned in any of the replies so =
far.
