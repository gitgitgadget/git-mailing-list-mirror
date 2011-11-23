From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Wed, 23 Nov 2011 19:02:35 +0700
Message-ID: <CACsJy8CuEaH33B_wrLo0BXYaYWi5tHB3tncftHhBQgiv9QcgaA@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 13:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTBXx-0003dO-7t
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 13:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab1KWMDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 07:03:09 -0500
Received: from mail-dy0-f46.google.com ([209.85.220.46]:52424 "EHLO
	mail-dy0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab1KWMDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 07:03:08 -0500
Received: by dyi18 with SMTP id 18so91356dyi.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 04:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ITegWiZHKdjxg/AzKJfjehhq1k+6ZlY8JCGiO332Sz0=;
        b=UH2Ol9ckpBH5bFGLEDCjpBZnBg4BT16z25R3nCYi8Iaek8ySXCrxDo1oSOWaLFCbXs
         7J8DtHg8xY9GIgOF8kqmvUAcLF8hqc2ToqxmGJCmAFl/7rfCqBNZdFR3AtkfnX+1KTdp
         f63znQ/J3IE4E96kWg/ggv7zCeXo3n65g5gF4=
Received: by 10.205.131.3 with SMTP id ho3mr23914076bkc.11.1322049786118; Wed,
 23 Nov 2011 04:03:06 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 23 Nov 2011 04:02:35 -0800 (PST)
In-Reply-To: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185843>

On Wed, Nov 23, 2011 at 3:28 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
> Hello,
>
> A lot of time when I want to use reset for smth else than "--hard" I
> have to go and look the documentation.

May be related: http://thread.gmane.org/gmane.comp.version-control.git/170266
-- 
Duy
