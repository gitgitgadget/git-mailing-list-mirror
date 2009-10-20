From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: ".dirty" suffix when building git from the source code
Date: Tue, 20 Oct 2009 14:06:32 +0200
Message-ID: <adf1fd3d0910200506q7ef95823qe461e77f8ce827be@mail.gmail.com>
References: <40378e40910200459i14b06002k1b805936e39b5022@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: bamakhrama@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 20 14:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0DU6-0000Tq-V6
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 14:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbZJTMG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 08:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbZJTMG3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 08:06:29 -0400
Received: from mail-ew0-f217.google.com ([209.85.219.217]:40599 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZJTMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 08:06:28 -0400
Received: by ewy17 with SMTP id 17so5274667ewy.39
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 05:06:32 -0700 (PDT)
Received: by 10.216.88.75 with SMTP id z53mr2361282wee.46.1256040392109; Tue, 
	20 Oct 2009 05:06:32 -0700 (PDT)
In-Reply-To: <40378e40910200459i14b06002k1b805936e39b5022@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130789>

On Tue, Oct 20, 2009 at 1:59 PM, Mohamed Bamakhrama
<bamakhrama@gmail.com> wrote:
> Hi all,
>
> I have cloned the git repository and built the v1.6.4.4 tag. The
> compilation went OK and I got the tool up and running. However, when I
> generate patches, I see that the tool comments the patches with
> "1.6.4.4.dirty".
>
> My question is: what is the meaning of the ".dirty" suffix?

It says that the git source code was modified when git was compiled.

HTH,
Santi
