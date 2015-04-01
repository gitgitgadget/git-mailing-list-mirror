From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Tue, 31 Mar 2015 17:40:06 -0700
Message-ID: <CAPc5daVeyrwO59uC-C4FfOwWtqfBxeZhhmfH6KeW0=2BUX1WHg@mail.gmail.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com> <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com>
 <xmqqegrw7omv.fsf@gitster.dls.corp.google.com> <4B764581-0053-467C-93B5-C238EF5AE112@his.com>
 <B30AC3FD-A046-40C4-8D37-70835205E446@his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kenneth Lorber <keni@his.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 02:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd6hs-0007B7-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 02:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbbDAAk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 20:40:28 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33011 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbDAAk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 20:40:27 -0400
Received: by obvd1 with SMTP id d1so54842711obv.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 17:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gEt6eaGXKxRihRzp5BGkVPfK4Y+BJRd/EnWdJJVLAP0=;
        b=ncTEoQDEfYaWnIFDG7xLpMZyggD4HKew0XDdNeuXCzXCAv2cSt3jxYOR/uUSPJrvq2
         XYivBD61ZOCj/sYZlZclUzVYdlxSX3KPu9HYMBVqFPIwyVKs7dvW0oL+eOhnPhl4F0xO
         X2Bp7zmx3ov2hOLLGCHGqAeNwyBLpc6bR86+TF27+7SaliluU9LdoH1uWaIUs0N4/vZ2
         F3ACkz0OVN/mv+43d5NI5JfkcdH96FQygF1132wBx1dS1owFuGbt8F/sR8g4lGq7v2RK
         SJfm35dZTyrOG+xcpJTx5bayc0NOpwoHeIZOqz0iAzmJvoWGsxJy5ejQ+41hqnNa12WX
         BNNQ==
X-Received: by 10.60.69.7 with SMTP id a7mr36306879oeu.55.1427848826827; Tue,
 31 Mar 2015 17:40:26 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Tue, 31 Mar 2015 17:40:06 -0700 (PDT)
In-Reply-To: <B30AC3FD-A046-40C4-8D37-70835205E446@his.com>
X-Google-Sender-Auth: 6OS_DkjxuVz6sL_NEKtSvtG_8DI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266587>

On Tue, Mar 31, 2015 at 5:10 PM, Kenneth Lorber <keni@his.com> wrote:
> Ping?  The original version of this got some discussion, but this version - nothing.

Pong? I do not know what you meant by "this version".

Have you followed Documentaiton/SubmittingPatches? Otherwise the
mailing list may have dropped the message.
