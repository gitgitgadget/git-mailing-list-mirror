From: David Aguilar <davvid@gmail.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Wed, 11 Apr 2012 20:27:01 -0700
Message-ID: <CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Pap_L=C3=B4rinc?= <paplorinc@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:27:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIAh9-0006VH-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 05:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041Ab2DLD1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 23:27:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40079 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab2DLD1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 23:27:02 -0400
Received: by yhmm54 with SMTP id m54so859618yhm.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 20:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Cy0v9py5EzxSZQ8n2SOWmDyDyhQl7L3Sn/ciiVbnsqU=;
        b=u74xD23RoGUXp8xLp6B9xyBDSCjS6jvu/197ezBkmaIkA2lZaqvnvKgdcChkhUt7jZ
         Fj+Vh8uCjjOVFaSWf/tgIvICstB1JhMvlcXxz63CdoYPYPd+gLqJ0ck3ampUjdjQprlk
         GCBChtoPsecWb2HR1xlY1pwUAvbq8WMW24pKAHcSqT6COgAfgGyvN7dFiZncBnybpVe6
         lcMpzKQ5T3kJ7CMe8DXQzgBhuhrpE57y94tKCkUuQTqst9d9aaD5AEjCf/n05QzR/tAv
         B+SMFin6+5GQ6lRwLO48RsBD1bx0y52ivpBu826YmjtZaxfV+VEV7Tnn5no7DHHB8Uzb
         2o9Q==
Received: by 10.236.73.195 with SMTP id v43mr657939yhd.78.1334201221487; Wed,
 11 Apr 2012 20:27:01 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Wed, 11 Apr 2012 20:27:01 -0700 (PDT)
In-Reply-To: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195291>

2012/4/11 Pap L=C3=B4rinc <paplorinc@yahoo.com>:
> Hello! :)
>
> We are working in parallel on the refactoring of a
> small project. The team uses SVN and I decided to give GIT a chance t=
o
> demonstrate it's merging capabilities I've read so much good about :)=
=2E
>
> However
> =C2=A0- I must be doing something VERY wrong - every time I try to me=
rge from
> =C2=A0the remote svn (git svn fetch and git merge remotebranch) into =
my
> branch, I get hundreds of conflicts, mostly because of moved folders.

Google is your friend

https://wiki.kuali.org/display/KULRICE/git-svn+how+to

http://flavio.castelli.name/howto_use_git_with_svn

http://viget.com/extend/effectively-using-git-with-subversion

http://java.dzone.com/articles/how-start-using-git-svn-based
--=20
David
