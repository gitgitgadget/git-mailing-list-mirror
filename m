From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Wed, 18 Feb 2009 09:04:47 +0100
Message-ID: <e5bfff550902180004x5e10e391wb80988fa892da413@mail.gmail.com>
References: <20090216212459.GA25046@efreet.light.src>
	 <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com>
	 <20090217192825.GA2216@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Feb 18 09:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZhRh-0003tk-7E
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 09:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZBRIEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 03:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZBRIEu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 03:04:50 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:58032 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbZBRIEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 03:04:49 -0500
Received: by bwz5 with SMTP id 5so5057761bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UMgH8hvzbZtQrovqKf1Cpnx0h/LYw1XL27WCMbRdVGs=;
        b=Ppq3Q9xEUG/LcVgPow815i46kOKW19c+jhwqy5WKoDTtx3t913Q0wRW7RZNSMnMehs
         hq+G2AmHQEPKzEO8FyqxqlPHaqQLO0QuHZwV++jRwV4S2FYLJdSojVnwzaP4WUlWqiy6
         aTKC3d20NrP7RW+a3MqMhmTveX2D9Lj7BnHTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gngt7T04PpEjnK5opgdxcMrn2wnDbP+hAtLzZ+42W2eoZjhaTvj1IYFf2BC5d6xkxO
         ztCo5VvFjbLlfvkKQE6PvRqePdcImWoPTg5xBs+nEAcPfWsK9LC5oQc6n6qjVqJuc5Ob
         vDaIu5iY2SFwTEbQASo/NO84DbNwPaYKWFtxs=
Received: by 10.181.146.11 with SMTP id y11mr1863403bkn.5.1234944287626; Wed, 
	18 Feb 2009 00:04:47 -0800 (PST)
In-Reply-To: <20090217192825.GA2216@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110512>

On Tue, Feb 17, 2009 at 20:28, Jan Hudec <bulb@ucw.cz> wrote:
>
> Often I need to configure some options in ~/.gitconfig and .git/config, but
> the GUIs generally only allow to set very few basic ones. I had to resort to
> editing ~/.gitconfig to turn off the cursed core.autocrlf, because git gui
> does not have that setting. And there are many more settings like that that
> users may want to tweak and something to guide them would be highly
> appreciated especially by the command-line-fearing windooze users.
>
> So my idea is to provide some kind of "property sheet" -- a treeview with all
> the sections and options with editable values with proper constraints (so
> boolean and enum values could be entered with drop-down menus) and
> descriptions.


This is nice. Thanks for the idea, I will implement that in qgit when
I find a bit of time :-)



Regarding your proposal I really wish you good luck and especially "have fun!!!"

For me it is like to trash out 95% of the stuff and start again from
zero because of the last 5% is missing (but I can add it anyway with
much smaller effort and time spent).

I understand the main reason, as per any GPL project, is having fun
and good time coding and exchanging ideas with peers, but I really
lack time and I am now moving to different interests. So, thank you
very much, but I think I'll stick with qgit.

Best
Marco
