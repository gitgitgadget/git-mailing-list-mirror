From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Remove some junk characters from COPYING
Date: Fri, 15 Jan 2010 13:52:30 +0530
Message-ID: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364c683b9308f6047d2fb530
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 09:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVhSZ-00075l-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 09:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0AOIWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 03:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897Ab0AOIWv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 03:22:51 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52532 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0AOIWu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 03:22:50 -0500
Received: by ywh6 with SMTP id 6so307507ywh.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 00:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=vfluUScnHPCXbSvAl4mOQR8Id3vKqkV5zv/B3xBx/Ps=;
        b=cMLLxycVgrEQYcU1xvTZtFslwbevtRMPn650glLZ6j+JHipTwR/hKeY52SeH/M91jy
         W/NLVjht6mxn97R6pmDGoEUYmouh2JH4j/+jtVlXxow3S9G/8+79DqrXzmqE+aqlZzZK
         bKkEbR5Fi3Lxiv5C0kCQ2rVM5mJinYvo+SxAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Tlx9oapgjYUbi5gyW9yeH9/Tc8lrEPRSX+FBEzEoFPyfM+yfpFrPOx2b+OqfpgBF0P
         UFfmZdok2nrmY5AWT4c4J174wdygzTw4m4rjEjJqQDIbUeaUEgn1HrWX5kqjvG2/wsYI
         UCv5spLPCRyMU+ZxueY8SC9qfWyn95XAtupzw=
Received: by 10.91.215.7 with SMTP id s7mr2054875agq.81.1263543770089; Fri, 15 
	Jan 2010 00:22:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137058>

--0016364c683b9308f6047d2fb530
Content-Type: text/plain; charset=ISO-8859-1

I removed a few ^L characters from COPYING. Kindly find patch
attached. Again, I'm sorry I couldn't include it inline- I'm behind a
restrictive firewall, and Gmail mangles up patches.

-- Ram

--0016364c683b9308f6047d2fb530
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Remove-some-junk-characters-from-COPYING.patch"
Content-Disposition: attachment; 
	filename="0001-Remove-some-junk-characters-from-COPYING.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4gp32gd0

RnJvbSA5YzU5YTE1ODhjNzk2YjAyMjkwMzU3M2VmN2YyODFkYWNjOGQ0ODU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1rdW1hciBSYW1hY2hhbmRyYSA8YXJ0YWdub25AZ21haWwu
Y29tPgpEYXRlOiBGcmksIDE1IEphbiAyMDEwIDEzOjQxOjM4ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gUmVtb3ZlIHNvbWUganVuayBjaGFyYWN0ZXJzIGZyb20gQ09QWUlORwoKU2lnbmVkLW9mZi1i
eTogUmFta3VtYXIgUmFtYWNoYW5kcmEgPGFydGFnbm9uQGdtYWlsLmNvbT4KLS0tCiBDT1BZSU5H
IHwgICAxMCArKysrKy0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9DT1BZSU5HIGIvQ09QWUlORwppbmRleCA2ZmY4N2M0
Li43OGUyMDhhIDEwMDY0NAotLS0gYS9DT1BZSU5HCisrKyBiL0NPUFlJTkcKQEAgLTc2LDcgKzc2
LDcgQEAgcGF0ZW50IG11c3QgYmUgbGljZW5zZWQgZm9yIGV2ZXJ5b25lJ3MgZnJlZSB1c2Ugb3Ig
bm90IGxpY2Vuc2VkIGF0IGFsbC4KIAogICBUaGUgcHJlY2lzZSB0ZXJtcyBhbmQgY29uZGl0aW9u
cyBmb3IgY29weWluZywgZGlzdHJpYnV0aW9uIGFuZAogbW9kaWZpY2F0aW9uIGZvbGxvdy4KLQwK
KwogCQkgICAgR05VIEdFTkVSQUwgUFVCTElDIExJQ0VOU0UKICAgIFRFUk1TIEFORCBDT05ESVRJ
T05TIEZPUiBDT1BZSU5HLCBESVNUUklCVVRJT04gQU5EIE1PRElGSUNBVElPTgogCkBAIC0xMzEs
NyArMTMxLDcgQEAgYWJvdmUsIHByb3ZpZGVkIHRoYXQgeW91IGFsc28gbWVldCBhbGwgb2YgdGhl
c2UgY29uZGl0aW9uczoKICAgICBMaWNlbnNlLiAgKEV4Y2VwdGlvbjogaWYgdGhlIFByb2dyYW0g
aXRzZWxmIGlzIGludGVyYWN0aXZlIGJ1dAogICAgIGRvZXMgbm90IG5vcm1hbGx5IHByaW50IHN1
Y2ggYW4gYW5ub3VuY2VtZW50LCB5b3VyIHdvcmsgYmFzZWQgb24KICAgICB0aGUgUHJvZ3JhbSBp
cyBub3QgcmVxdWlyZWQgdG8gcHJpbnQgYW4gYW5ub3VuY2VtZW50LikKLQwKKwogVGhlc2UgcmVx
dWlyZW1lbnRzIGFwcGx5IHRvIHRoZSBtb2RpZmllZCB3b3JrIGFzIGEgd2hvbGUuICBJZgogaWRl
bnRpZmlhYmxlIHNlY3Rpb25zIG9mIHRoYXQgd29yayBhcmUgbm90IGRlcml2ZWQgZnJvbSB0aGUg
UHJvZ3JhbSwKIGFuZCBjYW4gYmUgcmVhc29uYWJseSBjb25zaWRlcmVkIGluZGVwZW5kZW50IGFu
ZCBzZXBhcmF0ZSB3b3JrcyBpbgpAQCAtMTg5LDcgKzE4OSw3IEBAIGFjY2VzcyB0byBjb3B5IGZy
b20gYSBkZXNpZ25hdGVkIHBsYWNlLCB0aGVuIG9mZmVyaW5nIGVxdWl2YWxlbnQKIGFjY2VzcyB0
byBjb3B5IHRoZSBzb3VyY2UgY29kZSBmcm9tIHRoZSBzYW1lIHBsYWNlIGNvdW50cyBhcwogZGlz
dHJpYnV0aW9uIG9mIHRoZSBzb3VyY2UgY29kZSwgZXZlbiB0aG91Z2ggdGhpcmQgcGFydGllcyBh
cmUgbm90CiBjb21wZWxsZWQgdG8gY29weSB0aGUgc291cmNlIGFsb25nIHdpdGggdGhlIG9iamVj
dCBjb2RlLgotDAorCiAgIDQuIFlvdSBtYXkgbm90IGNvcHksIG1vZGlmeSwgc3VibGljZW5zZSwg
b3IgZGlzdHJpYnV0ZSB0aGUgUHJvZ3JhbQogZXhjZXB0IGFzIGV4cHJlc3NseSBwcm92aWRlZCB1
bmRlciB0aGlzIExpY2Vuc2UuICBBbnkgYXR0ZW1wdAogb3RoZXJ3aXNlIHRvIGNvcHksIG1vZGlm
eSwgc3VibGljZW5zZSBvciBkaXN0cmlidXRlIHRoZSBQcm9ncmFtIGlzCkBAIC0yNDYsNyArMjQ2
LDcgQEAgaW1wb3NlIHRoYXQgY2hvaWNlLgogCiBUaGlzIHNlY3Rpb24gaXMgaW50ZW5kZWQgdG8g
bWFrZSB0aG9yb3VnaGx5IGNsZWFyIHdoYXQgaXMgYmVsaWV2ZWQgdG8KIGJlIGEgY29uc2VxdWVu
Y2Ugb2YgdGhlIHJlc3Qgb2YgdGhpcyBMaWNlbnNlLgotDAorCiAgIDguIElmIHRoZSBkaXN0cmli
dXRpb24gYW5kL29yIHVzZSBvZiB0aGUgUHJvZ3JhbSBpcyByZXN0cmljdGVkIGluCiBjZXJ0YWlu
IGNvdW50cmllcyBlaXRoZXIgYnkgcGF0ZW50cyBvciBieSBjb3B5cmlnaHRlZCBpbnRlcmZhY2Vz
LCB0aGUKIG9yaWdpbmFsIGNvcHlyaWdodCBob2xkZXIgd2hvIHBsYWNlcyB0aGUgUHJvZ3JhbSB1
bmRlciB0aGlzIExpY2Vuc2UKQEAgLTI5OSw3ICsyOTksNyBAQCBQUk9HUkFNUyksIEVWRU4gSUYg
U1VDSCBIT0xERVIgT1IgT1RIRVIgUEFSVFkgSEFTIEJFRU4gQURWSVNFRCBPRiBUSEUKIFBPU1NJ
QklMSVRZIE9GIFNVQ0ggREFNQUdFUy4KIAogCQkgICAgIEVORCBPRiBURVJNUyBBTkQgQ09ORElU
SU9OUwotDAorCiAJICAgIEhvdyB0byBBcHBseSBUaGVzZSBUZXJtcyB0byBZb3VyIE5ldyBQcm9n
cmFtcwogCiAgIElmIHlvdSBkZXZlbG9wIGEgbmV3IHByb2dyYW0sIGFuZCB5b3Ugd2FudCBpdCB0
byBiZSBvZiB0aGUgZ3JlYXRlc3QKLS0gCjEuNi41Cgo=
--0016364c683b9308f6047d2fb530--
