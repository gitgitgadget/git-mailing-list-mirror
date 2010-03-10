From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 23:24:44 +0100
Message-ID: <46d6db661003101424m63509eefke482e52af62a900b@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>
	 <alpine.DEB.1.00.1003101329550.3006@intel-tinevez-2-302>
	 <46d6db661003100519v7fe84ffg4ffb1cf3aae15778@mail.gmail.com>
	 <4B97AB1F.8060406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUKh-0004Ft-KJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab0CJWYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:24:47 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35913 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab0CJWYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:24:46 -0500
Received: by bwz1 with SMTP id 1so5457300bwz.21
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ahUszBxc2mxxK9znIdSP5mN5Q5UGN0R37bovEOFAbno=;
        b=fJSPT+ApNGYqK/GbutPex297RHoSVjoXq30MtpPMoHIHr+Ui/caar4f0LGk28HQFAG
         xAstAx+VZivqzrZj/d3bjP3g3lDeiiS/MdxR0TlgIrWPxyz9laiO2J8qJz3Xg3ScsPXa
         gqwPRqES6jaAWJT5W0bOeW2iJvo7wANtk8vQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lKb3DQVs+IQHxt622LY/zTak8WqZ77jtEvK0ROOdKzaeTz58Z2i6OADMP4EcvN2rYx
         YkFBPnTFYAzcDxEYT0G/SudLI3TywzYsRdRuqE+1533zqySpyISOjoYR2cHxV7JxVs6l
         tmTMeqFriyRDey9sDey9XKDxk9NpxChk8F1+g=
Received: by 10.204.130.72 with SMTP id r8mr2666304bks.25.1268259884673; Wed, 
	10 Mar 2010 14:24:44 -0800 (PST)
In-Reply-To: <4B97AB1F.8060406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141925>

On Wed, Mar 10, 2010 at 3:22 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Christian MICHON schrieb:
>> On Wed, Mar 10, 2010 at 1:30 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> On Wed, 10 Mar 2010, Christian MICHON wrote:
>>>> This one feels weird here on Vista: .gitignore or .gitattributes end
>>>> up having no name visible at all on Explorer file view. I can only see
>>>> their real names once I fire the editor, on the title bar of the
>>>> editor. Is this expected ?
>
> Yes, when you have your Explorer in luser-mode. Go to the Options and
> *turn off* "Hide extensions of known files types". This unhides the "file
> extensions" .gitattributes, .gitignore, but also .txt, .doc, etc. that
> Windows knows about. :-P
>
> -- Hannes
>

damn. that was it and it's so simple: stupid me, I never bothered to
change those settings on vista.

thanks a bunch. I believe there's no need for the screenshot after all...

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
